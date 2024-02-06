resource "aws_ecr_repository" "repository" {
  for_each = var.repositories
  name = each.value
}
