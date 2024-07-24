mock_provider "aws" {
  override_data {
    target = data.aws_availability_zones.available
    values = {
        names = ["us-east-1a", "us-east-1b", "us-east-1c"]
    }
  }

}

run "check_the_correct_bucket_name" {
  assert {
    condition     = aws_s3_bucket.tfstate_template.bucket == "tfstate-template"
    error_message = "Wrong NAME value"
  }

  assert {
    condition     = aws_s3_bucket.tfstate_template.acl== "private"
    error_message = "Wrong ACL value"
  }
  assert {
    condition     = aws_s3_bucket.tfstate_template.force_destroy == true
    error_message = "Wrong FORCE_DESTROY value"
  }
  assert {
    condition     = aws_s3_bucket.tfstate_template.versioning[0].enabled == false
    error_message = "Wrong VERSIONING value"
  }
  assert {
    condition     = aws_s3_bucket.tfstate_template.server_side_encryption_configuration[0].rule[0].apply_server_side_encryption_by_default[0].sse_algorithm == "AES256"
    error_message = "Wrong SERVER_SIDE_ENCRYPTION_CONFIGURATION value"
  }
}
