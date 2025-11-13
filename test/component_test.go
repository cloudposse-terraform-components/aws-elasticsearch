package test

import (
	//"context"
	"fmt"
	"strings"
	"testing"

	// "github.com/aws/aws-sdk-go-v2/service/docdb"
	"github.com/cloudposse/test-helpers/pkg/atmos"
	helper "github.com/cloudposse/test-helpers/pkg/atmos/component-helper"

	// awshelper "github.com/cloudposse/test-helpers/pkg/aws"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/stretchr/testify/assert"
)

type ComponentSuite struct {
	helper.TestSuite
}

func (s *ComponentSuite) TestBasic() {
	const component = "elasticsearch/basic"
	const stack = "default-test"
	const awsRegion = "us-east-2"

	accountId := aws.GetAccountId(s.T())
	assert.NotNil(s.T(), accountId)

	inputs := map[string]interface{}{}

	defer s.DestroyAtmosComponent(s.T(), component, stack, &inputs)
	options, _ := s.DeployAtmosComponent(s.T(), component, stack, &inputs)
	assert.NotNil(s.T(), options)

	securityGroupId := atmos.Output(s.T(), options, "security_group_id")
	assert.True(s.T(), strings.HasPrefix(securityGroupId, "sg-"))

	domainArn := atmos.Output(s.T(), options, "domain_arn")
	assert.True(s.T(), strings.HasPrefix(domainArn, fmt.Sprintf("arn:aws:es:%s:%s:domain/eg-default-ue2-test-e-", awsRegion, accountId)))

	domainId := atmos.Output(s.T(), options, "domain_id")
	assert.True(s.T(), strings.Contains(domainId, "eg-default-ue2-test-e-"))

	domainEndpoint := atmos.Output(s.T(), options, "domain_endpoint")
	assert.True(s.T(), strings.HasPrefix(domainEndpoint, "vpc-eg-default-ue2-test-e-"))

	kibanaEndpoint := atmos.Output(s.T(), options, "kibana_endpoint")
	assert.True(s.T(), strings.HasPrefix(kibanaEndpoint, "vpc-eg-default-ue2-test-e-"))

	domainHostname := atmos.Output(s.T(), options, "domain_hostname")
	assert.True(s.T(), strings.HasPrefix(domainHostname, "es.") && strings.HasSuffix(domainHostname, ".components.cptest.test-automation.app"))

	kibanaHostname := atmos.Output(s.T(), options, "kibana_hostname")
	assert.True(s.T(), strings.HasSuffix(kibanaHostname, "components.cptest.test-automation.app"))

	userIamRoleName := atmos.Output(s.T(), options, "elasticsearch_user_iam_role_name")
	assert.Empty(s.T(), userIamRoleName)

	userIamRoleArn := atmos.Output(s.T(), options, "elasticsearch_user_iam_role_arn")
	assert.Empty(s.T(), userIamRoleArn)

	masterPasswordSSMKey := atmos.Output(s.T(), options, "master_password_ssm_key")
	assert.Equal(s.T(), masterPasswordSSMKey, "/elasticsearch/e/password")

	s.DriftTest(component, stack, &inputs)
}

// func (s *ComponentSuite) TestEnabledFlag() {
// 	const component = "elasticsearch/disabled"
// 	const stack = "default-test"
// 	const awsRegion = "us-east-2"

// 	s.VerifyEnabledFlag(component, stack, nil)
// }

func TestRunSuite(t *testing.T) {
	suite := new(ComponentSuite)

	suite.AddDependency(t, "vpc", "default-test", nil)

	subdomain := strings.ToLower(random.UniqueId())
	inputs := map[string]interface{}{
		"zone_config": []map[string]interface{}{
			{
				"subdomain": subdomain,
				"zone_name": "components.cptest.test-automation.app",
			},
		},
	}
	suite.AddDependency(t, "dns-delegated", "default-test", &inputs)
	helper.Run(t, suite)
}
