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
  organization = var.organization == null ? "" : lower(replace(var.organization, "/\\W/", ""))
  application  = var.application == null ? "" : var.application
  account      = var.account == null ? "" : var.account
  environment  = var.environment == null ? "" : lower(replace(var.environment, "/\\W/", ""))
  stack        = var.stack == null ? "" : var.stack

  context = {
    organization = local.organization
    application  = local.application
    account      = local.account
    environment  = local.account == local.environment ? "" : local.environment
    stack        = local.stack
  }

  tag_context = merge(local.context, {
    environment = local.environment
  })

  parts = [for l in var.order : local.context[l] if length(local.context[l]) > 0]

  id   = join("-", local.parts)
  path = "/${join("/", local.parts)}"
  tags = {
    for t in keys(local.tag_context) : title(t) => local.tag_context[t] if length(local.tag_context[t]) > 0
  }
}
