resource "aws_codepipeline" "pipeline" {
  name     = "${var.prefix}-${var.env}-${var.solution_name}"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.artifacts_bucket
    type     = "S3"

    encryption_key {
      id   = var.kms_key_id
      type = "KMS"
    }
  }

  stage {
    name = "GetSource"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceOutput"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github.arn
        FullRepositoryId = "HristoDimitrovv/terraform-project"
        BranchName       = var.branch_name
      }
    }
  }

  stage {
    name = "TerraformInitAndPlan"

    action {
      name             = "TerraformInitAndPlan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["TerraformOutput"]
      run_order        = 1

      configuration = {
        ProjectName = "${var.prefix}-${var.env}-${var.solution_name}-init-plan"
      }
    }
  }

  stage {
    name = "Approval"

    action {
      name      = "ApprovalAction"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 1
    }
  }

  stage {
    name = "TerraformApply"

    action {
      name            = "TerraformApply"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["SourceOutput"]
      run_order       = 1

      configuration = {
        ProjectName = "${var.prefix}-${var.env}-${var.solution_name}-apply"
      }
    }
  }
}