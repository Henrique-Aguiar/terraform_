terraform import aws_s3_bucket.dves_cloud dves.cloud
terraform import aws_s3_bucket_policy.dves_cloud dves.cloud
terraform import aws_s3_bucket_website_configuration.dves_cloud dves.cloud
terraform import aws_s3_bucket_acl.dves_cloud dves.cloud
terraform import aws_route53_zone.dves_cloud Z05706111QO8FQ09HY9PR
terraform import aws_route53_record.dves_cloud Z05706111QO8FQ09HY9PR_dves.cloud_A

terraform import aws_cloudfront_distribution.dves_cloud E3P4R7EX82H22U

terraform import aws_cloudfront_origin_access_control.dves_cloud E3P4R7EX82H22U

terraform import aws_route53_record.api_dves_cloud Z097388530WTCRQ6YUSLF_api_CNAME

terraform import aws_lambda_function.enviar_emails enviar-emails
terraform import aws_iam_role.enviar_emails_role enviar-emails-role-mu4rrjlm

terraform import aws_iam_policy.enviar_emails_role arn:aws:iam::285552379206:policy/service-role/AWSLambdaBasicExecutionRole-fde8933b-3c2f-4bb4-98af-1199050fe0c9 