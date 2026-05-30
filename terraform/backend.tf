terraform {
  backend "s3" {
    bucket         = "kingsly-terraform-state"
    key            = "multi-stack-project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "kingsly-terraform-locks"
    encrypt        = true
  }
}
