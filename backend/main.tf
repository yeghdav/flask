
resource "aws_s3_bucket" "default" {
  bucket = "flask-application-testing-us-east-1"

  lifecycle {
    #    prevent_destroy = true
  }
  tags = merge(
    {
      "Description" = "Terraform State bucket"
    }
  )
}

resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.default.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "default" {
  bucket = aws_s3_bucket.default.id
  acl    = "private"
  depends_on = [
  aws_s3_bucket_ownership_controls.owner
  ]
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.default.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "owner" {
  bucket = aws_s3_bucket.default.id
   rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_dynamodb_table" "default" {
  name           = "flask-application-testing-us-east-1"
  hash_key       = "LockID"
  read_capacity  = 10
  write_capacity = 10
  server_side_encryption {
    enabled = false
  }

  point_in_time_recovery {
    enabled = false
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
    {
      "Description" = "Terraform State Lock table"
    }
  )
}


data "aws_caller_identity" "current" {}
