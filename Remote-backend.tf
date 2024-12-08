terraform {
  backend "s3" {
    bucket = "bucket-v1-1"
    dynamodb_table = "dynamodb-state-locking"
    key = "statefiles/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}