// Copyright © 2021 Daniel Morris.
// All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at:
//
// https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package main

import (
	"encoding/json"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

type context struct {
	Organization string `json:"organization,omitempty"`
	Application  string `json:"application"`
	Account      string `json:"account"`
	Environment  string `json:"environment,omitempty"`
	Stack        string `json:"stack"`
}

// TestMultipleEnvironmentAccount tests that when the account and environment
// context variables are different, both parts are included in the outputs.
func TestMultipleEnvironmentAccount(t *testing.T) {
	testContext, _ := json.Marshal(&context{
		Organization: "honestempire",
		Application:  "example",
		Account:      "nonlive",
		Environment:  "acceptance",
		Stack:        "assets",
	})

	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/complete",
		Upgrade:      true,
		Vars: map[string]any{
			"context": string(testContext),
		},
	})

	defer terraform.Destroy(t, options)

	terraform.InitAndApply(t, options)

	id := terraform.Output(t, options, "test_bucket_id")
	assert.True(t, strings.HasPrefix(id, "example-nonlive-acceptance-assets"))
	name := terraform.Output(t, options, "test_ssm_parameter_name")
	assert.Equal(t, "/example/nonlive/acceptance/assets/TEST", name)
}

// TestSingleEnvironmentAccount tests that when the account and environment
// context variables are the same, then it only appears once in the outputs.
func TestSingleEnvironmentAccount(t *testing.T) {
	testContext, _ := json.Marshal(&context{
		Organization: "honestempire",
		Application:  "example",
		Account:      "nonlive",
		Environment:  "nonlive",
		Stack:        "assets",
	})

	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/complete",
		Upgrade:      true,
		Vars: map[string]any{
			"context": string(testContext),
		},
	})

	defer terraform.Destroy(t, options)

	terraform.InitAndApply(t, options)

	id := terraform.Output(t, options, "test_bucket_id")
	assert.True(t, strings.HasPrefix(id, "example-nonlive-assets"))

	name := terraform.Output(t, options, "test_ssm_parameter_name")
	assert.Equal(t, "/example/nonlive/assets/TEST", name)
}

func TestHyphenatedStack(t *testing.T) {
	testContext, _ := json.Marshal(&context{
		Organization: "honestempire",
		Application:  "example",
		Account:      "nonlive",
		Environment:  "uat",
		Stack:        "website-v1",
	})

	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/complete",
		Upgrade:      true,
		Vars: map[string]any{
			"context": string(testContext),
		},
	})

	defer terraform.Destroy(t, options)

	terraform.InitAndApply(t, options)

	id := terraform.Output(t, options, "test_bucket_id")
	assert.True(t, strings.HasPrefix(id, "example-nonlive-uat-website-v1"))

	name := terraform.Output(t, options, "test_ssm_parameter_name")
	assert.Equal(t, "/example/nonlive/uat/website-v1/TEST", name)
}
