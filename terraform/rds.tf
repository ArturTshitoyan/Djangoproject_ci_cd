resource "aws_db_subnet_group" "db_subnet" {
  name       = "db_subnet"
  subnet_ids = [aws_subnet.private-us-east-1c.id, aws_subnet.private-us-east-1e.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_security_group" "rds-sg" {
  name        = "RDS-sg"
  description = "no internet access"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name      = "RDS-sg"
    Role      = "private"
    ManagedBy = "terraform"
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = [var.vpc_cidr]

  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "django-postgres" {
  identifier              = "django-website"
  allocated_storage       = 20
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.id
  engine                  = "postgres"
  engine_version          = "12"
  instance_class          = "db.t3.micro"
  db_name                 = "djangoproject"
  username                = "djangoproject"
  password                = var.rds_pass
  publicly_accessible     = false
  storage_type            = "gp2"
  vpc_security_group_ids  = [aws_security_group.rds-sg.id]
  skip_final_snapshot     = true
}