output "bucket_name" {
  description = "S3 bucket for static website"
  value = module.home_arcanum_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 bucket website Endpoint"
  value = module.home_arcanum_hosting.website_endpoint
}

output "cloudfront_url" {
  description = "CloudFront Distribution Domain Name URL"
  value = module.home_arcanum_hosting.domain_name
}