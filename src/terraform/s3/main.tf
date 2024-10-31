resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

locals {
  bucket_name = "hardening-bucket-${random_string.unique_id.result}"
}

module "log_bucket" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=master"

  bucket_name = "logging-bucket-${random_string.unique_id.result}"

  storage_admin_service_account = {
    name_prefix = "netology-terraform-s3"
  }

  max_size = 1073741824
}

module "s3" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=master"

  bucket_name = local.bucket_name

  storage_admin_service_account = {
    name_prefix = "netology-terraform-s3"
  }

  max_size = 1073741824

  policy = {
    enabled = true
    statements = [
      {
        sid     = "example-rule-allow-upload-from-ip-for-all-auth-users"
        effect  = "Allow"
        actions = ["s3:PutObject"]
        resources = [
          "${local.bucket_name}",
          "${local.bucket_name}/*"
        ]
        principal = {
          type        = "CanonicalUser"
          identifiers = ["system:allAuthenticatedUsers"]
        }
        condition = {
          type   = "IpAddress"
          key    = "aws:SourceIp"
          values = ["72.14.201.45/32"]
        }
      }
    ]
  }

  policy_console = {
    enabled = true
  }

  versioning = {
    enabled = true
  }

  lifecycle_rule = [
    {
      enabled = true
      id      = "cleanupoldlogs"
      expiration = {
        days = 365
      }
    },
    {
      enabled = true
      id      = "cleanupoldversions"
      noncurrent_version_transition = {
        days          = 60
        storage_class = "COLD"
      }
      noncurrent_version_expiration = {
        days = 150
      }
    }
  ]

  logging = {
    target_bucket = module.log_bucket.bucket_name
    target_prefix = "logs/"
  }

  server_side_encryption_configuration = {
    enabled = true
  }
}
