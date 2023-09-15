resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "tf_state_lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "terraform_s3_state_lock" {
  bucket              = "terraformstatelock" #update the bucket name at your convenience
  object_lock_enabled = true
}

resource "aws_s3_bucket_acl" "tf_s3_acl" {
  bucket = aws_s3_bucket.terraform_s3_state_lock.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "tf_s3_version" {
  bucket = aws_s3_bucket.terraform_s3_state_lock.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object" "tf_state_object" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.tf_s3_version]
  key    = aws_s3_object.object.key
  bucket = aws_s3_bucket.terraform_s3_state_lock.id
  force_destroy                 = true
}

resource "aws_s3_object" "object" {
  key    = "terraform.tfstate"
  bucket = aws_s3_bucket.terraform_s3_state_lock.id
  source = "terraform.tfstate"
}