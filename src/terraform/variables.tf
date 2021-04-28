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

variable "system_nodepool_nodes_count" {
  type = number
  default = 1
}

variable "system_nodepool_vm_size" {
  type = string
  default = "Standard_D2_v2"
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

variable "keyvault_name" {
  type = string
  default = "spbootkeyv2021am"
}

variable "managed_identity_name" {
  type = string
  default = "spbootmi2021am"
}

variable "tenant_id" {
  type = string
}

variable "private-ep-subnet-address" {
  type = string
  default = "10.5.1.0/28"
}

variable "az-fw-subnet-address" {
  type = string
  default = "10.5.2.0/26"
}

variable "pip_name" {
  type = string
  default = "spbootam2021-pip"
}

variable "fw_name" {
  type = string
  default = "spboot2021am-fw"
}

variable "rt_name" {
  type = string
  default = "spbootam2021-route-table"
}

variable "log_analytics_workspace_sku" {
  description = "The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  description = "The retention period for the logs in days"
  type        = number
  default     = 30
}