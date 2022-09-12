variable "region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "domain_name" {
  type        = string
  description = "domain name"
  default     = "andranik-sedrakyan.acadevopscourse.xyz"
}

variable "subdomain_name" {
  type        = string
  description = "domain name"
  default     = "reg.andranik-sedrakyan.acadevopscourse.xyz"
}

variable "db_domain_name" {
  type        = string
  description = "domain name"
  default     = "db.andranik-sedrakyan.acadevopscourse.xyz"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "AWS VPC CIDR range"
}

variable "cluster_name" {
  type        = string
  description = "eks cluster name"
  default     = "Dev"
}

variable "cluster_version" {
  type        = string
  description = "eks cluster version"
  default     = "1.22"
}

variable "public_key_location" {
  type        = string
  description = "EC2 public key location"
  default     = "./server_key.pub"
}

variable "rds_pass" {
  type        = string
  description = "AWS RDS DB Password"
  sensitive   = true
}

