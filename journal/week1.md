# Terraform Beginner Bootcamp 2023 - Week 1

## Root Modules Structure

The root module structure is as follows: 

```
PROJECT_ROOT
│
├── main.tf                 # All the remaining things (Terraform looks for all .tf files)
├── variables.tf            # Stores input variables and its structure
├── terraform.tfvars        # To load environment variables for Terraform project
├── providers.tf            # Defines require providers and its configuration. It can also include modules
├── outputs.tf              # All Outputs are stored here
└── README.md               # Required by the root module
```

> Readme file: Root module must have a readme file by the name of `README` or `README.md`

**[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)**

