# Create a storage for Terraform state. 
# Need full path in path, cant use variables
terraform {
  backend "local" {
    #path = "/opt/tmp/tfstate/terraform.tfstate"
    path = "config/.state/tfstate/terraform.tfstate"
  }
}