provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "dynamodb_access_role" {
  name = "dynamodb-acesso-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "dynamodb_access_policy" {
  name        = "read-write-dynamodb-policy"
  description = "Política para ler e escrever no dynamodb"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DynamoDBAccess",
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem",
        "dynamodb:Scan",
        "dynamodb:Query"
      ],
      "Resource": "arn:aws:dynamodb:us-east-1:437054333024:table/carros"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "dynamodb_access_policy_attachment" {
  role       = aws_iam_role.dynamodb_access_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

output "role_arn" {
  value = aws_iam_role.dynamodb_access_role.arn
}
