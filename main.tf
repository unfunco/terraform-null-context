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
    account     = var.account == null ? var.context.account : var.account
    environment = var.environment == null ? var.context.environment : var.environment
    component   = var.component == null ? var.context.component : var.component
    attributes  = compact(distinct(concat(coalesce(var.context.attributes, []), coalesce(var.attributes, []))))
  }

  enabled = local.input.enabled

  namespace   = local.input.namespace == null ? "" : lower(local.input.namespace)
  account     = local.input.account == null ? "" : lower(local.input.account)
  environment = local.input.environment == null ? "" : lower(local.input.environment)
  component   = local.input.component == null ? "" : lower(local.input.component)
  attributes  = compact(distinct([for v in local.input.attributes : lower(v)]))

  local_context = {
    namespace   = local.namespace
    account     = local.account
    environment = local.environment
    component   = local.component
    attributes  = local.attributes
  }

  label_order = ["namespace", "account", "environment", "component"]
  labels      = [for l in local.label_order : local.local_context[l] if length(local.local_context[l]) > 0]

  id = join("-", concat(distinct(local.labels), local.attributes))

  output_context = {
    enabled     = local.enabled
    namespace   = local.namespace
    account     = local.account
    environment = local.environment
    component   = local.component
    attributes  = local.attributes
  }
}
