variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "simple-msk-cluster"
}

variable "kafka_version" {
  default = "2.8.1"
}

variable "number_of_broker_nodes" {
  default = 2
}
