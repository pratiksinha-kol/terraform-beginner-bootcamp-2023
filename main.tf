terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length  = 20
  special = false
}

output "random_bucket_name" {
  value = upper(random_string.bucket_name.result)
}

output "random_bucket_id" {
  value = random_string.bucket_name.id
}