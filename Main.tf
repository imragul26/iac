terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3"
}

provider "aws" {
  region = "us-east-1" # change if needed
}

module "msk" {
  source  = "terraform-aws-modules/msk-kafka-cluster/aws"
  version = "~> 2.2.0"

  cluster_name = "my-msk-cluster"
  kafka_version = "2.8.1"
  number_of_broker_nodes = 2

  broker_node_instance_type = "kafka.m5.large"
  vpc_id = var.vpc_id
  broker_node_client_subnets = var.subnet_ids
}
