// Copyright © 2021 Honest Empire Ltd
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

locals {
  input = {
    enabled     = var.enabled == null ? var.context.enabled : var.enabled
    namespace   = var.namespace == null ? var.context.namespace : var.namespace
    environment = var.environment == null ? var.context.environment : var.environment
    name        = var.name == null ? var.context.name : var.name
  }

  enabled     = local.input.enabled
  namespace   = lower(local.input.name)
  environment = lower(local.input.environment)
  name        = lower(local.input.name)

  id = join("-", [local.namespace, local.environment, local.name])

  output_context = {
    enabled     = local.enabled
    namespace   = local.namespace
    environment = local.environment
    name        = local.name
  }
}
