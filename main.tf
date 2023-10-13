terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
 cloud {
   organization = "pratiksinha-org"

   workspaces {
     name = "terra-house-1"
   }
  }
}


provider "terratowns" {
  # endpoint = "http://localhost:4567/api"
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_token
}

module "home_arcanum_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.arcanum.public_path
  content_version = var.arcanum.content_version
}

resource "terratowns_home" "home" {
  name = "How to play Arcanum in 2023"
  description = <<DESCRIPTION
Arcanum is a game from 2001 that shipped with alot of bugs.
Modders have removed all the originals making this game really fun
to play (despite that old look graphics). This is my guide that will
show you how to play arcanum without spoiling the plot.
DESCRIPTION
  domain_name = module.home_arcanum_hosting.domain_name
  # town = "gamers-grotto"
  town = "missingo"
  content_version = var.arcanum.content_version
}


module "home_maxpayne_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.maxpayne.public_path
  content_version = var.maxpayne.content_version
}

resource "terratowns_home" "home_maxpayne" {
  name = "Max Payne Video game"
  description = <<DESCRIPTION
Max Payne is a neo-noir third-person shooter video game series developed by Remedy Entertainment and Rockstar Studios. 
The series is named after its protagonist, Max Payne.
He is a New York City police detective turned vigilante after his family was murdered by drug addicts.
This is one of my favorite games as a youngster. 
DESCRIPTION
  domain_name = module.home_maxpayne_hosting.domain_name
  # domain_name = "3psh3gz.cloudfront.net"
  # town = "gamers-grotto"
  town = "missingo"
  content_version = var.maxpayne.content_version
}