terraform {
  backend "s3" {
    bucket = "s3-terraform-state-lock-dynamo"
    key    = "Day-7/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock-prudhvi"

  }
}