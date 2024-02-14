terraform {
  backend "s3" {
    bucket         = "devops-gitlab-tf-state-bucket-dont-delete"
    key            = "devops-gitlab/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "devops-gitlab-state-locking-table-dont-delete"
  }
}
