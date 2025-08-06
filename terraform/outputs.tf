output "s3_upload_command" {
  description = "Command to upload images to the S3 bucket"
  value       = "aws s3 cp ./images/ s3://${module.s3_bucket.s3_bucket_id}/ --recursive"
}

output "s3_image_base_url" {
  description = "Base URL to access public images in the S3 bucket"
  value       = "https://${module.s3_bucket.s3_bucket_id}.s3.us-east-1.amazonaws.com"
}
