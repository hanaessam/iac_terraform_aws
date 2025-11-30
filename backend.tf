
terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket-example123"
    region  = "us-east-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
}
