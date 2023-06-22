
resource "aws_s3_bucket" "my_bucket_henrique_dev" {

  bucket = "my-bucket-henrique-dev"

  tags = {
    importado = "18/06/2023"
    Owner     = local.common_tags.Owner
    ManagedBy = local.common_tags.ManagedBy
  }

}