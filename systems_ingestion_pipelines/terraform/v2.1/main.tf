
#            +-------------- resource followed by type, separated by underscore
#            | 
#            |            +------------ Name of datasource 
#            |            |  NOTE: instance and name is a unique name of resource that can 
#            |            |  can now access data source attributed  
#            |            |  i.e. data.resource_type.resource_name.attributed
#            |            |       data.aws_subnet.selected_subnet.id
# data block v            V   
data "aws_subnet" "selected_subnet" {
    id = "subnet-0597ece886ea42f19"
}

data "aws_ami" "latest_amazon_linux" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "architecture"
        value=  ["x86_64"]
    } 
    filter {
        name = "name"
        valuevalues =  ["a1201*-ami-202*"]
    }
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
    ami = data.aws_ami.latest_amazon_linux.id       # NOTE uses data source declared above !!
    instance_type = "t2.mico"
    subnet_id = data.aws_subnet.selected_subnet.id   # NOTE uses data source declared above !!
    tags = {
        Name = var.server_name    ## Also here, we are using the variable declared below !!
    }
}
