This Repo is for creating infrastructure for djangoproject continous integration and contionous deployment.

You need terraform and ansible installed on your localhost.

Infrastructure will be on AWS. 

Terraform will create

  - Custom VPC

  - 3 public subnets for EKS nodes, 1 public subnet for operation instance and 2 private subnets for RDS

  - Internet gateway

  - Route table associated with internet gateway

  - 4 public subnets will be associated with public route table

  - Ops EC2 instance with security group 22, 443, 8081, 3000 ports opened

  - RDS with security group 5432 port opened and Postgres 12 engine installed

  - EKS cluster with 1 node group and opened 30001 port

  - Network Load Balancer with target group 30001 port opened and listener target to port 80

  - Cloudfront with NLB origin and 80, 443 ports

  - Generate certeficate for already registered domain in route53

  - Alias A record for cloudfront

  - A record for nexus container registry in ops EC2 instance

  - CNAME record for RDS endpoint

Ansible will create in ops EC2 instance

  - Nexus repository container with djangoproject repository created
  
  - Nginx reverse proxy container to redirect https to http trafik and pass it nexus
  
  - Prometheus, grafana and Node exporter containers for monitoring Ops Server
  
  - Install local github runner

Before execute run.sh you need to create secrets in Github actions in djangoproject source repository
  
  - ACCESS_KEY (your aws account Access key ID)
  
  - SECRET_KEY (your aws account Secret Access Key)

  - EKS_CLUSTER_NAME (named in terraform eks.tf file)
  
  - NEXUS_REPO (Nexus repository name)
  
  - NEXUS_USERNAME (Nexus repository username)
  
  - NEXUS_PASSWORD (Nexus repository password)
  
  - SQL_HOST (DB subdomain name)
  
  - SQL_PASSWORD (DB password manually inputed while terraform creates infrastructure) 

You need also

- Create github access token with repo access and store it in "github_token.txt" file in ansible directory

- Create public and private ssh keys for creating ec2 instance and store in terraform directory

Finnaly execute run.sh and manually input db password and use same password to create secret in github action.
