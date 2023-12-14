### KMS Key ###
resource "aws_kms_key" "pipeline" {
  description = "KMS key for the pipeline"
}

