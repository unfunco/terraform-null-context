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

locals {
  input = {
    organisation = var.organisation == "" ? var.context.organisation : var.organisation
    application  = var.application == "" ? var.context.application : var.application
    account      = var.account == "" ? var.context.account : var.account
    environment  = var.environment == "" ? var.context.environment : var.environment
    stack        = var.stack == "" ? var.context.stack : var.stack
    tags         = merge(var.context.tags, var.tags)
  }

  organisation = local.input.organisation == null ? "" : lower(replace(local.input.organisation, "/\\W/", ""))
  application  = local.input.application == null ? "" : lower(replace(local.input.application, "/\\W/", ""))
  account      = local.input.account == null ? "" : lower(replace(local.input.account, "/\\W/", ""))
  environment  = local.input.environment == null ? "" : lower(replace(local.input.environment, "/\\W/", ""))
  stack        = local.input.stack == null ? "" : lower(replace(local.input.stack, "/\\W/", ""))

  local_context = {
    organisation = local.organisation
    application  = local.application
    account      = local.account
    environment  = local.environment
    stack        = local.stack
  }

  labels      = [for l in var.label_order : local.local_context[l] if length(local.local_context[l]) > 0]
  path_labels = [for p in var.path_order : local.local_context[p] if length(local.local_context[p]) > 0]

  id   = join("-", distinct(local.labels))
  path = "/${join("/", distinct(local.path_labels))}"

  tags = {
    for t in keys(local.local_context) : title(t) => local.local_context[t] if length(local.local_context[t]) > 0
  }

  output_context = {
    organisation = local.organisation
    application  = local.application
    account      = local.account
    environment  = local.environment
    stack        = local.stack
    tags         = local.tags
  }
}
