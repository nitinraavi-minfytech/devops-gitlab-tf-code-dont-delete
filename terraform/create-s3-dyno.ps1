#set Region
$region = "us-east-1"

# Set the name for your S3 bucket and DynamoDB table
$s3BucketName = "devops-gitlab-tf-state-bucket-dont-delete"
$dynamoDBTableName = "devops-gitlab-state-locking-table-dont-delete"
$parameterPath = "/devops/gitlab/rds/password/dontdelete"
$parameterValue = "oeSATSPUpU0hhycN"

# Create an S3 bucket
aws s3api create-bucket --bucket $s3BucketName

# Create a DynamoDB table for S3 state locking
aws dynamodb create-table --table-name $dynamoDBTableName `
    --attribute-definitions AttributeName=LockID,AttributeType=S `
    --key-schema AttributeName=LockID,KeyType=HASH `
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5


# Create Parameter in Parameter Store
aws ssm put-parameter --name $parameterPath --value $parameterValue --type SecureString --region $region