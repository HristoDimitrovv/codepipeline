### CodePipeline Variables ###

variable "bucket_name" {
  description = "Bucket name"
  type        = string
  default     = "hrdimibucket-for-codepipeline11"
}

variable "bucket_name1" {
  description = "Bucket name"
  type        = string
  default     = "hrdimibucket-for-codepipeline11"
}

variable "solution_name" {
  description = "Solution name used in the naming convention of codepipeline"
  type        = string
  default     = "github"
}
variable "tf_version" {
  description = "Terraform version used to apply in the code"
  default     = "1.4.6"
}
variable "prefix" {
  description = "Resource name prefix."
  type        = string
  default     = "core"
}
variable "env" {
  description = "Environment or account name - shared, dev, uat or prod"
  type        = string
  default     = "dev"
}
variable "solution_source_path" {
  description = "Relative path to the solution folder with terraform code e.g. environment/core/shared/solutions/ad_services"
  type        = string
  default     = "./terraform/environment"
}
