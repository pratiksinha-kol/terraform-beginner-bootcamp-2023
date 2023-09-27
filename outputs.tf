output "bucket_name" {
  description = "S3 bucket for static website"
  value = module.terrahouse_aws.bucket_name
}