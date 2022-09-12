This Repo is for creating infrastructure for djangoproject continous integration and contionous deployment.

You need terraform and ansible installed on your localhost.

Infrastructure will be on AWS. 

Terraform will create

  - custom VPC

  - 3 public subnets for EKS nodes, 1 public subnet for operation instance and 2 private subnets for RDS

  - internet gateway

  - route table associated with internet gateway

  - 4 public subnets will be associated with public route table

  - 1 EC2 instance with security group 22, 443, 8081, 3000 ports opened

  - RDS with security group 5432 port opened and postgres 12 engine

  - EKS cluster with 1 node group and opened 30001 port

  - Network Load Balancer with target group 30001 port opened and listener target to port 80

  - cloudfront with NLB origin and 80, 443 ports

  - generate certeficate for already registered domain in route53

  - alias A record for cloudfront

  - A record for nexus container registry in ops EC2 instance

  - CNAME record for RDS endpoint

Ansible will create in ops EC2 instance Nexus repository, nginx reverse proxy, prometheus, grafana, node exporter containers and install local github runner.

Before execute run.sh you need to create secrets in Github actions ( ACCESS_KEY (your aws Access key ID), SECRET_KEY (your aws Secret Access Key),
EKS_CLUSTER_NAME (named in terraform tf files), NEXUS_PASSWORD (your nexus repo password), NEXUS_REPO (Nexus repo name), NEXUS_USERNAME (Repo password),  SQL_HOST (db subdomain), SQL_PASSWORD (db password manually inputed while terraform creates infrastructure). 

You need also create github access token with repo access and store it in "github_token.txt" file in root directory, create public and private ssh keys for creating ec2 instance.
Finnaly execute run.sh and manually input db password and use same password to create secret in github action.



