resource "aws_codecommit_repository" "my-repo" {
  repository_name = "my-repo"
  description     = "CodeCommit repository connected with the pipeline"
}