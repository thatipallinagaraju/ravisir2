output "ecr_url" {
  value = data.aws_ecr_repository.repo.repository_url
}