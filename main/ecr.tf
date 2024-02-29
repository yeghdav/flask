module "ecr" {
  source = "../modules/ecr"
  repositories = [
    "flask"
  ]
}
