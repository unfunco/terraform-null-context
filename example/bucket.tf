resource "aws_s3_bucket" "example_bucket" {
  bucket = module.this.id
  tags   = module.this.tags
}

output "example_bucket_id" {
  value = aws_s3_bucket.example_bucket.id
}

output "example_bucket_tags" {
  value = aws_s3_bucket.example_bucket.tags
}
