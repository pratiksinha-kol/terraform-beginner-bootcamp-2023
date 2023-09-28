# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Git Tags

If you have inadvertantly tagged a git branch and want to correct it, then you must have to change it locally and then remotely. 

To delete a specific `tag locally` ====> 

```
git tag -d 0.4.0

or 

git tag -d <tag_name>
```

To delete `tag remotely` ====>

```
git push --delete origin 0.4.0

OR

git push --delete origin <tag_name>
```

Now go to your commit history and grab the `SHA` of that commit that you want to `retag`. 

```
git checkout <SHA>
git tag Major.Minor.Patch
git push --tags
git checkout main
```

Read [here](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/) to know more about it. 

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


## Dealing With Configuration Drift

### What to do when you loose your Terraform State file 

There would be some instances where you will loose your terraform Sate file. One way is by deleteing all your resources manually. Another way is to import the resources. However, it must be noted that it doesn't work for all resouces. Check the Terraform Registry for more information.   

### Fix Missing Resources with Terraform Import

To import existing resources, you can use `import`. There is another way to import resources which is by defining **[block](https://developer.hashicorp.com/terraform/language/import)**.

```
import {
  to = aws_instance.example
  id = "i-abcd1234"
}

resource "aws_instance" "example" {
  name = "hashi"
  # (other resource arguments...)
}

```
We are going to use **[CLI](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)** for importing resources. Here we are importing an exsting S3 bucket:  

```
terraform import aws_s3_bucket.bucket bucket-name
```

### Fix manual configuration

Someone in your organization might inadvertently delete or modifies any resource, we must be able to detect the changes. 

The easiest way to detect the change is by running `terraform plan`. It will list all the changes. You can apply those changes and revert back your Terraform state to the previous state by using **[Configuration Drift](https://www.hashicorp.com/blog/detecting-and-managing-drift-with-terraform)**.

## Terraform Modules

### Terraform Module Structure

Whenever you plan to use modules for terraform, it is recommended to use a `modules` directory but it an be given any name especially when developing on local environment. 

### Module Sources

Terraform provides loads of options to import modules. They can be imported from:
  * Github
  * Bitbucket
  * S3 Bucket
  * Terraform Registry
  * Local Paths (We are using this method)
  * and many ***[more](https://developer.hashicorp.com/terraform/language/modules/sources)***....


### Passing Input Variables

As we had discussed earlier, it is recommended to use a dedicated `variables.tf`. Hence, before importing them in our module, we must define and declare these variables in the `variables.tf` file. 

Now, to use these variables in our module, we can use similar to the example given below: 

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

> To know more about Modules, visit the ***[Official Website](https://developer.hashicorp.com/terraform/language/modules/sources)***

## Fix Output using Terraform Refresh

To modify the Terraform state, you can use `terraform refresh`. It is important to point out that it doesn't modify real remote objects, but will only modify Terraform state. You don't need to use this command as `terraform plan` and `terraform apply` both performs the same action. This is also the reason why this [command](https://developer.hashicorp.com/terraform/cli/commands/refresh) is deprected. 

In the given command, we just need to refrsh our output without changing any real objects. 

```tf
terraform apply -refresh --auto-approve

OR

terraform apply -refresh-only -auto-approve

```

## Working with files in Terraform


### Path Variable


#### **[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)**

In Terraform, there is a special variable called `path` that allows us to reference local paths:
 - path.module: Get the path for the current module
 - path.root: Get the path for the root module

Here is a sample of uploading [object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) to S3 bucket: 

```
resource "aws_s3_object" "error.html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = "${path.root}/public/error.html"
}
```


### Checking existence of file while Configuring variables

Whenever there is a need to check the existence of the file, you can use [Terraform function](https://developer.hashicorp.com/terraform/language/functions/fileexists) to do that. Under the resource `variable`, you can choose to perform validation `condition     = fileexists(var.index_html_filepath)`.  

Here is an example where we ***validate*** the existence of the file:

```
variable "error_html_filepath" {
  description = "The file path for error.html"
  type        = string

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The provided path for error.html does not exist."
  }
}
```

### filemd5 Function

It hashes the contents of a given file rather than a literal string. Find out [more](https://developer.hashicorp.com/terraform/language/functions/filemd5).