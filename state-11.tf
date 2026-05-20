terraform {
  backend "s3" {
    bucket  = "cf-templates-aj0bjjqfxn49-us-east-1"
    key     = "terraform/lesson-7/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
