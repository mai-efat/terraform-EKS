# ECR Repository Resource

resource "aws_ecr_repository" "my_ecr_repo" {
  name = "my-ecr-repository"

#   lifecycle {
#     prevent_destroy = true  # Optional: Prevent accidental deletion of the repository
#   }

  tags = {
    Name        = "MyECRRepository"
    Environment = "Production"
  }
}
data "aws_caller_identity" "current" {}


# 3. Create the IAM Policy for ECR access
resource "aws_iam_policy" "ecr_access_policy" {
  name        = "ECRAccessPolicy"
  description = "Allows read access to the specific ECR repository"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:ecr:us-east-1:${data.aws_caller_identity.current.account_id}:repository/${aws_ecr_repository.my_ecr_repo.name}"
      }
    ]
  })
}
#attach policy to to node role 
resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  role       = aws_iam_role.nodes.name
  policy_arn = aws_iam_policy.ecr_access_policy.arn
}