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
    regtion = 'us-east-1'
}

#              +-------------- resource followed by type, separated by underscore
#              | 
#              |            +------------ Name of resource 
#              |            |  NOTE: instance and name is a unique name of resource that can 
#              |            |        be referenced in other blocks
#              |            |            i.e. aws_instance.webserver
#              |            |        required arguments for instance is Ami and instance typ
#              |            |           ami == amazon machie image, OS etc.
# resources    v            V   
resource "aws_instance" "webserver" {
    ami = "ami-08a0d1e16fc3f61ea"
    instance_type = "t2.mico"
    tags = {
        Name = "ExampleServer"
    }
}

# input
# output
