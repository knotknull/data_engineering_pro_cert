
The difference between terraform/v2 and terraform/v2.1 is that 
terraform/v2.1 is refactored to pull everything out of main.tf and 
split up accordingly: 
  - main.tf       ## holds the resources, this could also be broken down as a .tf per resource
  - outputs.tf    ## holds the outputs
  - variables.tf  ## holds the variables
  - providers.tf  ## holds the terraform settings and provider
