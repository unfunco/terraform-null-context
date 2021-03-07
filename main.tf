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
    customer    = var.customer == null ? var.context.name : var.customer
    account     = var.account == null ? var.context.account : var.account
    environment = var.environment == null ? var.context.environment : var.environment
  }

  enabled     = local.input.enabled
  customer    = lower(local.input.customer)
  account     = lower(local.input.account)
  environment = lower(local.input.environment)

  id = join("-", [local.customer, local.account, local.environment])

  output_context = {
    enabled     = local.enabled
    customer    = local.customer
    account     = local.account
    environment = local.environment
  }
}
