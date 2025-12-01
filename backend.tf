terraform {
  backend "s3" {
    bucket         = "streamlinepay-prod-tfstate"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "streamlinepay-prod-locks"
    encrypt        = true
  }
}
