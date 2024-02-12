module "code_pipeline" {
  source                = "./cicd"
  prefix                = var.prefix
  env                   = var.env
  solution_name         = var.solution_name
  artifacts_bucket      = module.byoi_s3.bucket_id
  kms_key_id            = aws_kms_key.pipeline.id
  codepipeline_role_arn = aws_iam_role.codepipeline.arn
  codebuild_role_arn    = aws_iam_role.codebuild.arn
  # The below variables are replaced in the buildpec files in the module. They need to be passed everytime.
  environment_variables = {
    solutions_source_path = var.solution_source_path // path to the solution in CodeCommit repo
    tf_version            = var.tf_version
  }
}
