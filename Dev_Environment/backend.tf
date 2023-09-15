terraform {
  backend "s3" {
    bucket = "terraformstatelockyo"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf_state_lock"
  }
}
