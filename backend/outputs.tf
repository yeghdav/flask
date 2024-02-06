
output "bucket" {
  value       = aws_s3_bucket.default.bucket
}

output "dynamodb_table" {
  value       = aws_dynamodb_table.default.name
}
