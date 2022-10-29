variable "bucket_for_glue" {
  description = "Bucket for AWS Glue..."
  default = "poc-aws-glue-etl-process"
}

variable "glue_catalog_database" { 
default = "poc-database"
}
