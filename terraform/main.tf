#####################################################################################
# S3 Bucket for hosting images for the Frontend App with Public Access Enabled
# https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest
#####################################################################################

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.3.1"

  bucket = "eks-workshop-img-bucket-${local.aws_account_id}"

  # Enables the S3 Object Ownership feature for this bucket.
  control_object_ownership = true

  # Sets the ownership rule for new objects uploaded to this bucket.
  # "BucketOwnerPreferred" means that the bucket owner will automatically
  # become the owner of any new object, regardless of who uploads it.
  object_ownership = "BucketOwnerPreferred"

  # This block disables safeguards and enables public access
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  # Enable this in order to allow adding custom S3 bucket policies
  attach_policy = true

  # Allow public read access to the objects
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::eks-workshop-img-bucket-${local.aws_account_id}/*"
      }
    ]
  })

  versioning = {
    enabled = true
  }

  tags = {
    Terraform = true
  }
}