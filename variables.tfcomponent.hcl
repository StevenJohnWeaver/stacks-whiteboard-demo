variable "region"            { type = string }
variable "role_arn"          { type = string }
variable "identity_token"    { type = string }
variable "default_tags"      { type = map(string) default = {} }
variable "cluster_name"      { type = string default = "stacks-demo" }
variable "kubernetes_version"{ type = string default = "1.30" }
variable "vpc_cidr"          { type = string default = "10.100.0.0/16" }