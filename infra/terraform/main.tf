terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/Users/ivan/.aws/credentials"]
  shared_config_files      = ["/Users/ivan/.aws/config"]
}

resource "aws_ecrpublic_repository" "ps-app-repo" {
  repository_name = "ps-app-repo"
}

output "ps-app-repo-name" {
  value = aws_ecrpublic_repository.ps-app-repo.repository_name
}

resource "local_file" "tf-outputs" {
  filename = "${path.root}/app-repo-uri"
  content  = aws_ecrpublic_repository.ps-app-repo.repository_uri
}
