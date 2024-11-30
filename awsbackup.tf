resource "aws_backup_vault" "my_vault" {
  name = "my-backup-vault"
}

resource "aws_backup_plan" "backup" {
  name = "my-backup-plan"


  rule {
    target_vault_name = aws_backup_vault.my_vault.name
    rule_name           = "DailyBackupRule"
    schedule            = "cron(0 12 * * ? *)"  # Backup every day at 12:00 PM UTC
    

    lifecycle {
      delete_after = 20  # Delete backups after 20 days
    }
  }
}
resource "aws_backup_selection" "selection" {
  iam_role_arn = aws_iam_role.my_backup_role.arn

  name         = "test_selection"
  plan_id      = aws_backup_plan.backup.id

  resources = [
    "arn:aws:ec2:eu-north-1:676206908022:instance/i-0ea3a33b5ff4c2d36"
    
  ]
 
}
resource "aws_iam_role" "my_backup_role" {
  name               = "my-backup-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "backup.amazonaws.com"
      }
    }
  ]
}
EOF
}