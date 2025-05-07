provider "aws" {
  region = "us-east-1" # Change if needed
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_groups" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "msk" {
  source  = "terraform-aws-modules/msk-kafka-cluster/aws"
  version = "2.0.1"

  cluster_name           = "simple-msk-cluster"
  kafka_version          = "2.8.1"
  number_of_broker_nodes = 2

  broker_node_client_subnets = data.aws_subnets.default.ids
  broker_node_security_groups = [data.aws_security_groups.default.ids[0]]

  encryption_in_transit {
    client_broker = "PLAINTEXT"
    in_cluster    = true
  }
}
