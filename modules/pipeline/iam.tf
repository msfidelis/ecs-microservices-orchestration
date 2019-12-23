resource "aws_iam_role" "codepipeline_role" {
  name               = format("codepipeline-%s-%s-role", var.cluster_name, var.app_service_name)
  assume_role_policy = file(format("%s/templates/policies/codepipeline_role.json", path.module))
}

data "template_file" "codepipeline_policy" {
  template = file(format("%s/templates/policies/codepipeline.json", path.module))

  vars = {
    aws_s3_bucket_arn = aws_s3_bucket.source.arn
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = format("codepipeline-%s-%s-policy", var.cluster_name, var.app_service_name)
  role   = aws_iam_role.codepipeline_role.id
  policy = data.template_file.codepipeline_policy.rendered
}

resource "aws_iam_role" "codebuild_role" {
  name               = format("codebuild-%s-%s-role", var.cluster_name, var.app_service_name)
  assume_role_policy = file(format("%s/templates/policies/codebuild_role.json", path.module))
}

data "template_file" "codebuild_policy" {
  template = file(format("%s/templates/policies/codebuild_policy.json", path.module))

  vars = {
    aws_s3_bucket_arn = aws_s3_bucket.source.arn
  }
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name    = format("codebuild-%s-%s-policy", var.cluster_name, var.app_service_name)
  role    = aws_iam_role.codebuild_role.id
  policy  = data.template_file.codebuild_policy.rendered
}
