output "bucket_name" {
  description = "S3 bucket for static website"
  value = module.terrahouse_aws.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 bucket website Endpoint"
  value = module.terrahouse_aws.website_endpoint
}

output "cloudfront_url" {
  description = "CloudFront Distribution Domain Name URL"
  value = module.terrahouse_aws.cloudfront_url
}