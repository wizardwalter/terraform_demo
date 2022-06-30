terraform {
  backend "s3"{
      bucket = "terraform-state10155"
      key = "dev/terraform_state"
  }
}