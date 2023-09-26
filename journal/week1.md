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

### Migrate from Terraform Cloud to Remote

There might a requirement for you to move back to remote. In that case, the first thing to do is to delete the `.terraform.lock` file and `.terraform` directory. Additionally, you need to **comment** out the the cloud block where you have mentioned the provider section 

```
  # cloud {
  #   organization = "name-of-your-org"

  #   workspaces {
  #     name = "workspace-name"
  #   }
  # }
```

### Terraform Input Variables

To make your module much more reuseable and configurable, we can use [Input variables](https://developer.hashicorp.com/terraform/language/values/variables). 

#### Variable Definition Precedence 

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

- Environment variables (Lowest Precedence)
- The terraform.tfvars file, if present.
- The terraform.tfvars.json file, if present.
- Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames. 
- Any -var and -var-file options on the command line, in the order they are provided. (Highest Precedence)



If you are working with lot of variables, it is better to create a file by the name of `.tfvars` or `.tfvars.json`.

For example: here is using variables using `-var`

```
terraform plan -var user_uuid='20e78f 0a-78c0-2248-a3e1-de1bd3e65321458'

terraform plan -var="user_uuid=20e78f 0a-78c0-2248-a3e1-de1bd3e65321458"
```

```
terraform plan -var-file="testing.tfvars"
```

#### Terraform Cloud Variables

There are two ways to define **[variables](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/variables)** on Terraform Cloud
- Using Terraform Variables: Used by Terafform modules
- Using Environment Variables: Used by the Project i.e. AWS Credentials.

***These variables can be sensitive or non-sensitive***


