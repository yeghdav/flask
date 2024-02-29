resource "aws_docdb_subnet_group" "flask" {
  name       = "flask"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "My docdb subnet group"
  }
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = var.db_name
  db_subnet_group_name    = "flask"
  engine                  = "docdb"
  master_username         = "root"
  master_password         = "example1"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  depends_on = [
    aws_docdb_subnet_group.flask
  ]
}
