# Create a storage for Terraform state. 
terraform {
  backend "local" {
    path = "backend_path"
    #"/home/jea/tmp/tfstate/terraform.tfstate"
  }
}