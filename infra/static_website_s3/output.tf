output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.static_files.arn
}

output "name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.static_files.id
}

output "hosted_zone_id" {
  description = "S3 Route53 Hosted Zone ID"
  value       = aws_s3_bucket.static_files.hosted_zone_id
}

output "domain" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket_website_configuration.static_files.website_domain
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.static_files.website_endpoint
}
