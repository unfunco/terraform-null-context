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

locals {
  input = {
    enabled      = var.enabled == null ? var.context.enabled : var.enabled
    organisation = var.organisation == null ? var.context.organisation : var.organisation
    application  = var.application == "" ? var.context.application : var.application
    account      = var.account == null ? var.context.account : var.account
    stage        = var.stage == null ? var.context.stage : var.stage
    stack        = var.stack == null ? var.context.stack : var.stack
    attributes   = compact(distinct(concat(coalesce(var.context.attributes, []), coalesce(var.attributes, []))))
    tags         = merge(var.context.tags, var.tags)
  }

  enabled = local.input.enabled

  organisation = local.input.organisation == null ? "" : lower(local.input.organisation)
  application  = local.input.application == null ? "" : lower(local.input.application)
  account      = local.input.account == null ? "" : lower(local.input.account)
  stage        = local.input.stage == null ? "" : lower(local.input.stage)
  stack        = local.input.stack == null ? "" : lower(local.input.stack)
  attributes   = compact(distinct([for v in local.input.attributes : lower(v)]))

  local_context = {
    organisation = local.organisation
    account      = local.account
    stage        = local.stage
    stack        = local.stack
    attributes   = join("-", local.attributes)
  }

  label_order = var.label_order
  labels      = [for l in local.label_order : local.local_context[l] if length(local.local_context[l]) > 0]

  id = join("-", distinct(local.labels))

  tags = {
    for t in keys(local.local_context) : title(t) => local.local_context[t] if length(local.local_context[t]) > 0
  }

  output_context = {
    enabled      = local.enabled
    organisation = local.organisation
    application  = local.application
    account      = local.account
    stage        = local.stage
    stack        = local.stack
    attributes   = local.attributes
    tags         = local.tags
  }
}
