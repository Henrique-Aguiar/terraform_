resource "aws_s3_bucket" "dves_cloud" {

  bucket = "dves.cloud"

  tags = {

    Name = "My bucket"

    Environment = "Dev"

  }

}

resource "aws_s3_bucket_policy" "dves_cloud" {
  bucket = aws_s3_bucket.dves_cloud.id
  policy = file("${path.module}/policies/dves-cloud.json")
}

resource "aws_s3_bucket_website_configuration" "dves_cloud" {
  bucket = aws_s3_bucket.dves_cloud.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "dves_cloud" {
  for_each = fileset("doctorcare/", "*")
  bucket   = aws_s3_bucket.dves_cloud.id
  key      = each.value
  source   = "doctorcare/${each.value}"
  etag     = filemd5("doctorcare/${each.value}")
}

resource "aws_s3_object" "dves_cloud_assets" {
  for_each = fileset("doctorcare/assets/", "*")
  bucket   = aws_s3_bucket.dves_cloud.id
  key      = "assets/${each.value}"
  source   = "doctorcare/assets/${each.value}"
  etag     = filemd5("doctorcare/assets/${each.value}")
}

resource "aws_s3_bucket_public_access_block" "dves_cloud" {
  bucket = aws_s3_bucket.dves_cloud.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}