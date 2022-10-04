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
	Organisation string `json:"organisation,omitempty"`
	Application  string `json:"application"`
	Account      string `json:"account"`
	Environment  string `json:"environment"`
	Stack        string `json:"stack"`
}

func testID(t *testing.T) {
	exampleContext, _ := json.Marshal(&context{
		Organisation: "honestempire",
		Application:  "example",
		Account:      "nonlive",
		Environment:  "acceptance",
		Stack:        "assets",
	})

	options := &terraform.Options{
		TerraformDir: "../examples/complete",
		Upgrade:      true,
		Vars: map[string]any{
			"context": string(exampleContext),
		},
	}

	defer terraform.Destroy(t, options)

	id := terraform.Output(t, options, "test_bucket_id")
	assert.True(t, strings.HasPrefix(id, "example-nonlive-acceptance-assets"))
}
