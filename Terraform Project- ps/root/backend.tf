terraform {
  backend "s3" {
    bucket = "tfstate-gunjan-100"
    key    = "backend/tfstate-gunjan-100.tfstate"
    region = "us-east-1"
    dynamodb_table = "remote-backend"
  }
}