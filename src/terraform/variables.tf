variable "resource_group" {
  type = string
  default = "SpringBootAppRG"
}

variable "location" {
  type = string
  default = "australiaeast"
}

variable "vnet-name" {
  type = string
  default = "spring-vnet"
}

variable "vnet-address" {
  type = string
  default = "10.5.0.0/22"
}

variable "aks-subnet-name" {
  type = string
  default = "aks-subnet"
}

variable "aks-subnet-address" {
  type = string
  default = "10.5.0.0/24"
}

variable "tags" {
  type = map
  default = {
    environment = "training"
    app      = "springboot"
  }
}



variable "kubernetes-version" {
  type = string
  default = "1.19.7"
}

variable "aks-prefix" {
  type = string
  default = "springboot"
}

variable "aks-agents-az" {
  type = list(number)
  default = ["1", "2"]
}

variable "aks-private-cluster-enabled" {
  type = bool
  default = true
}

variable "aks_admin_group_id" {
  type = string
}

variable "sql_server_admin_pwd" {
  type = string
}

variable "sql_server_admin_login" {
  type = string
}

variable "sql_server_name" {
  type = string
}

variable "sql_db_name" {
  type = string
}

variable "sql_db_edition" {
  type = string
  default = "GeneralPurpose"
}

# "GP_S_Gen5_2" i.e. Gen5 and vcpu=2 - S stands for serverless
variable "sql_db_sku" {
  type = string
  default = "GP_S_Gen5_2"
}

variable "acr_name" {
  type = string
  default = "spbootacr2021am"
}