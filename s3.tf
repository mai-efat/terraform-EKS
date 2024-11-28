resource "aws_s3_bucket" "elb_logs" {
  bucket = "my-elb-logs-s3"

  # Optional: Set versioning for the bucket
  versioning {
    enabled = true
  }

  # Enable ACL to allow log delivery by the ELB service
  acl = "private"
}

resource "aws_s3_bucket_object" "elb_log_object" {
  bucket = aws_s3_bucket.elb_logs.bucket
  key    = "access-logs-prefix/"
  acl    = "bucket-owner-full-control"
}
resource "aws_s3_bucket_policy" "elb_log_policy" {
  bucket = aws_s3_bucket.elb_logs.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.elb_logs.arn}/*"
      }
    ]
  })
}

