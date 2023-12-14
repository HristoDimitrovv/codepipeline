### CodeBuild role ### 
resource "aws_iam_role" "codebuild" {
  name               = "codebuild"
  assume_role_policy = data.aws_iam_policy_document.assume-codebuild-role.json
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "codebuild-policy"
  role   = aws_iam_role.codebuild.id
  policy = file("${path.module}/pipeline-roles/codebuild.json")
}

### CodePipeline role ### 
resource "aws_iam_role" "codepipeline" {
  name               = "codepipeline"
  assume_role_policy = data.aws_iam_policy_document.assume-codepipeline-role.json
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "codepipeline-policy"
  role   = aws_iam_role.codepipeline.id
  policy = file("${path.module}/pipeline-roles/codepipeline.json")
}