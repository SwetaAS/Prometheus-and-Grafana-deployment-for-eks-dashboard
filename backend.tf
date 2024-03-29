terraform {
  backend "s3" {
    bucket         = "terraform-bucket24"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
