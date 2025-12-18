/* terraform {
  backend "s3" {
    bucket         = "streamlinepay-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "streamlinepay-terraform-locks"
    encrypt        = true
  }
}
*/