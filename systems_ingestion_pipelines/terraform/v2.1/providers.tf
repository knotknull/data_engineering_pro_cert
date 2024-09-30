# terraform settings 
terraform {
#   +-------- name or provder that were declared in required_provider  
#   | 
#   V 
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = ">= 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

#           +-------- name or provder that were declared in required_provider  
#           | 
# providers v       
provider aws {
    region = var.region  ## Look Ma, we are using the variable declared below !!
}