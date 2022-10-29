resource "aws_glue_catalog_database" "aws_glue_catalog_poc_database" {
  name = var.glue_catalog_database

  create_table_default_permission {
    permissions = ["SELECT"]

    principal {
      data_lake_principal_identifier = "IAM_ALLOWED_PRINCIPALS"
    }
  }
}



resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = "poc_table"
  database_name = aws_glue_catalog_database.aws_glue_catalog_poc_database.name
}


resource "aws_glue_classifier" "aws_glue_csv_classifier" {
  name = "csv-classifier"

  csv_classifier {
    header = ["PRODUCT_NAME", "COUNTRY", "PRICE", "QUANTITY"]
    contains_header = "ABSENT"
    quote_symbol = "\""
    delimiter = ","
  }
}

resource "aws_glue_crawler" "aws_glue_custom_csv_crawler" {
  name = "poc_custom-csv-crawler"
  database_name = aws_glue_catalog_database.aws_glue_catalog_poc_database.name
  classifiers = [aws_glue_classifier.aws_glue_csv_classifier.id]
  role = aws_iam_role.aws_iam_glue_role.arn

  s3_target {
    path = "s3://var.bucket_for_glue/raw/"
  }
}