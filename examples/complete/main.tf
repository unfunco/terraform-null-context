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

provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "test" {
  bucket_prefix = module.context.id
  tags          = module.context.tags
}

resource "aws_ssm_parameter" "test" {
  name  = join("/", [module.context.path, "TEST"])
  tags  = module.context.tags
  type  = "SecureString"
  value = "CorrectHorseBatteryStaple"
}

output "test_bucket_id" {
  value = aws_s3_bucket.test.id
}

output "test_bucket_tags" {
  value = aws_s3_bucket.test.tags
}

output "test_ssm_parameter_name" {
  value = aws_ssm_parameter.test.name
}
