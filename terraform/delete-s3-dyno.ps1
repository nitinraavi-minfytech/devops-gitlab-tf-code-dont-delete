$region = "us-east-1"

# Set S3 Bucket Name and DynamoDB Table Name
$s3BucketName = "devops-gitlab-tf-state-dont-delete"
$dynamoDBTableName = "devops-gitlab-state-locking-table-dont-delete"
$parameterPath = "/devops/gitlab/rds/password/dontdelete"

# Delete S3 Bucket
aws s3 rb s3://$s3BucketName --force

# Delete DynamoDB Table
aws dynamodb delete-table --table-name $dynamoDBTableName --region $region

# Delete Parameter from Parameter Store
aws ssm delete-parameter --name $parameterPath --region $region
