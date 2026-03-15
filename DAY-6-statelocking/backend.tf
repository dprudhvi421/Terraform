terraform {
  backend "s3" {
    bucket = "terraform-state-file-s3-prudhvi"
    key    = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}
