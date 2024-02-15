#set Region
$region = "us-east-1"

# Set the name for your S3 bucket and DynamoDB table
$s3BucketName = "devops-gitlab-tf-state-bucket-dont-delete"
$dynamoDBTableName = "devops-gitlab-state-locking-table-dont-delete"
$parameterPath = "/devops/gitlab/rds/password/dontdelete"


if ($args[0] -eq "CREATE") {
# Create an S3 bucket
aws --version
aws s3api create-bucket --bucket $s3BucketName

# Create a DynamoDB table for S3 state locking
aws dynamodb create-table --table-name $dynamoDBTableName `
    --attribute-definitions AttributeName=LockID,AttributeType=S `
    --key-schema AttributeName=LockID,KeyType=HASH `
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5


# Generate Password 
function New-RandomPassword {
    param(
        [int]$Length = 20,
        [bool]$IncludeSpecialCharacters = $false
    )

    $ValidCharacters = 'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789'
    if ($IncludeSpecialCharacters) {
        $ValidCharacters += '!@#$%^&*()_-+=[]{}|;:,.<>?'
    }

    $Password = ''
    $Random = New-Object System.Random
    1..$Length | ForEach-Object {
        $Password += $ValidCharacters[$Random.Next(0, $ValidCharacters.Length)]
    }

    return $Password
}
}
# Usage
$GeneratedPassword = New-RandomPassword -Length 16 -IncludeSpecialCharacters $false
# Create Parameter in Parameter Store
aws ssm put-parameter --name $parameterPath --value $GeneratedPassword --type SecureString --region $region


#Delete
if ($args[0] -eq "DELETE") {
    # Delete S3 Bucket
    aws s3 rb s3://$s3BucketName # Make sure you delete the data before deleting the s3.

    # Delete DynamoDB Table
    aws dynamodb delete-table --table-name $dynamoDBTableName --region $region

    # Delete Parameter from Parameter Store
    aws ssm delete-parameter --name $parameterPath --region $region
}