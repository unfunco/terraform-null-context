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

  organisation = var.organisation
  application  = var.application
  account      = var.account
  environment  = var.environment
  stack        = var.stack
  tags         = var.tags
}

variable "context" {
  default = {
    account      = ""
    application  = ""
    organisation = ""
    stack        = ""
    environment  = ""
    tags         = {}
  }

  description = "Single object used for setting the entire context at once."

  type = object({
    account      = string
    application  = string
    organisation = string
    stack        = string
    environment  = string
    tags         = object({})
  })
}

variable "organisation" {
  default     = ""
  description = "The name of the organisation."
  type        = string
}

variable "application" {
  default     = ""
  description = "The name of the application."
  type        = string
}

variable "account" {
  default     = ""
  description = "The name of the account."
  type        = string
}

variable "environment" {
  default     = ""
  description = "The name of the environment."
  type        = string
}

variable "stack" {
  default     = ""
  description = "The name of the stack."
  type        = string
}

variable "tags" {
  default     = {}
  description = "A map of tags to be applied to resources."
  type        = object({})
}
