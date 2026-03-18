# IAM Role (who you are) --> Create IAM Role (for EC2)
#        ↓
# IAM Policy (what you can do) --> Create IAM Policy (S3 permissions) Define what access you want
#        ↓
# Attach Policy to Role  -->  Attach Policy to Role
#        ↓
# Instance Profile (bridge for EC2) --> Create IAM Instance Profile, EC2 cannot directly use a role — it needs an instance profile wrapper.
#        ↓
# EC2 Instance (uses the role) -->   Attach the role to EC2 via instance profile.


# create an IAM role for EC2 to assume
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Create custom IAM Policy with  (S3 permissions)
resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3-access-policy"
  description = "Allow EC2 to access S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::my-bucket",
          "arn:aws:s3:::my-bucket/*"
        ]
      }
    ]
  })
}

# attach the S3 access policy to the EC2 role
resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
  depends_on = [ aws_iam_policy.s3_access_policy ]
}

# creating profile for EC2 to use the role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_s3_role.name
}

# Launching ec2 instance with instance profile
resource "aws_instance" "name" {
  instance_type = "t3.micro"
  ami           = "ami-0c2b8ca1dad447f8a"
  tags = {
    Name = "custom-iam-instance"
  }
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

}