## Terrahome AWS


```tf
module "home_maxpayne" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.maxpayne_public_path
  content_version = var.content_version
}
```

The public directory expects the following:
- index.html
- error.html
- assets

We have made specific folders and under which all the above files and assets are available. 

>FYI: All top level files in assets will be copied, but not any subdirectories.