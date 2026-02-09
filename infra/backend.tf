terraform {
  backend "s3" {
    bucket = "tf-state-devops"
    key    = "vke/terraform.tfstate"

    region = "us-east-1"

    endpoints = {
      s3 = "https://blr1.vultrobjects.com"
    }

    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }
}

