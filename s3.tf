module "s3" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = var.bucket_for_glue
  //tags = var.tags
	
}  