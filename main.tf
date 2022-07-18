terraform {
  backend "azurerm" {
      resource_group_name = "terraformstoragerg"
      storage_account_name = "terraformstorage55"
      container_name = "test1"
      key = "terraform.test1"
      access_key = "eaa8dae0-e229-4aa5-841d-e2eb0ac76625"
  }
}

provider "azurerm" {
    features {
      
    }
    subscription_id = var.subscription_id
    client_id = var.client_id
    client_secret = var.client_secret
    tenant_id = var.tenant_id
}
variable "subscription_id" {
    type = string
    default = "eaa8dae0-e229-4aa5-841d-e2eb0ac76625"
    description = "Dev subcription id"
  
}

variable "client_id" {
    type = string
    default = "86004665-4cd0-4364-9273-7577ae34f711"
    description = "client id"
  
}

variable "client_secret" {
    type = string
    default = "e6f8Q~Mbmm0QWMwlPcLPmRj-LtAN0rPW6JQN1b3I"
    description = "client secret"
  
}

variable "tenant_id" {
    type = string
    default = "d2fafc32-16ef-42fe-95a8-0bfb0d5f2b20"
    description = "tenant id"
  
}

locals {
  setup_name ="practice-hyd"
}
resource "azurerm_resource_group" "testrglabel" {
    name = "testrgeastus"
    location = "East US"
    tags = {
      "name" = "${local.setup_name}-rsg"
    }

  
}
resource "azurerm_app_service_plan" "testappplan" {
    name = "testappplan"
    location = azurerm_resource_group.testrglabel.location
    resource_group_name = azurerm_resource_group.testrglabel.name
    sku {
      tier = "standard"
      size = "S1"
    }
    depends_on = [
      azurerm_resource_group.testrglabel
    ]
    tags = {
      "name" = "${local.setup_name}-appplan"
    }
  
}

resource "azurerm_app_service" "testwebapp" {
    name = "testwebapp569"
    location = azurerm_resource_group.testrglabel.location
    resource_group_name = azurerm_resource_group.testrglabel.name
    app_service_plan_id = azurerm_app_service_plan.testappplan.id
    tags = {
      "name" = "${local.setup_name}-webapp"
    }
    depends_on = [
      azurerm_app_service_plan.testappplan
    ]
  
}
