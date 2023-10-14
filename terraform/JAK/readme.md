Terraform create:
- Azure Windows Web App .NET 6
- SQL Database + SQL Server

# pattern node:

prefix: $project_$env_$version_resourceType

# local
terraform init
terraform plan -var-file="c1-dev-terraform.tfvars"
