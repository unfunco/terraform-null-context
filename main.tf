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
  organisation = var.organisation == null ? "" : lower(replace(var.organisation, "/\\W/", ""))
  application  = var.application == null ? "" : lower(replace(var.application, "/\\W/", ""))
  account      = var.account == null ? "" : lower(replace(var.account, "/\\W/", ""))
  environment  = var.environment == null ? "" : lower(replace(var.environment, "/\\W/", ""))
  stack        = var.stack == null ? "" : lower(replace(var.stack, "/\\W/", ""))

  context = {
    organisation = local.organisation
    application  = local.application
    account      = local.account
    environment  = local.account == local.environment ? "" : local.environment
    stack        = local.stack
  }

  parts = [
    for l in var.label_order : local.context[l] if length(local.context[l]) > 0
  ]

  id   = join("-", local.parts)
  path = "/${join("/", local.parts)}"
  tags = {
    for t in keys(local.context) : title(t) => local.context[t] if length(local.context[t]) > 0
  }
}
