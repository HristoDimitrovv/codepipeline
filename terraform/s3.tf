#Create an S3 bucket
resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
}


#Setup versioning for S3
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = "Disabled"
  }
}


#Set up encryption of the objects
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.s3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
