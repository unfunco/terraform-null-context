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

module "context" {
  source = "../../"

  organisation = var.context.organisation
  application  = var.context.application
  account      = var.context.account
  environment  = var.context.environment
  stack        = var.context.stack
}

variable "context" {
  description = "Single object for setting the entire context."

  type = object({
    organisation = optional(string)
    application  = string
    account      = string
    environment  = optional(string)
    stack        = string
  })
}
