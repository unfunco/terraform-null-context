// Copyright © 2021 Honest Empire Ltd.
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
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExample(t *testing.T) {
	options := &terraform.Options{
		TerraformDir: "../example",
		Upgrade:      true,
	}

	defer terraform.Destroy(t, options)

	terraform.InitAndApply(t, options)

	bucketID := terraform.Output(t, options, "example_bucket_id")
	assert.True(t, strings.HasPrefix(bucketID, "example-nonlive-uat-bucket-uploads"))

	bucketTags := terraform.OutputMap(t, options, "example_bucket_tags")
	assert.Equal(t, "honestempire", bucketTags["Organisation"])
	assert.Equal(t, "example", bucketTags["Application"])
	assert.Equal(t, "nonlive", bucketTags["Account"])
	assert.Equal(t, "uat", bucketTags["Stage"])
	assert.Equal(t, "bucket", bucketTags["Stack"])
	assert.Equal(t, "uploads", bucketTags["Attributes"])

	ssmParameterID := terraform.Output(t, options, "example_ssm_parameter_id")
	assert.Equal(t, t, "/example/nonlive/uat/EXAMPLE", ssmParameterID)

	ssmParameterTags := terraform.OutputMap(t, options, "example_ssm_parameter_tags")
	assert.Equal(t, "honestempire", ssmParameterTags["Organisation"])
	assert.Equal(t, "example", ssmParameterTags["Application"])
	assert.Equal(t, "nonlive", ssmParameterTags["Account"])
	assert.Equal(t, "uat", ssmParameterTags["Stage"])
}
