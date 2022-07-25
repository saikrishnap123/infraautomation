terraform {
  backend "azurerm" {
      resource_group_name = "storgerg"
      storage_account_name = "terraformstorage149"
      container_name = "test1"
      key = "terraform.test1"
      access_key = "PA/L+mCYNdWnmOHbWiSTj3TJ+lhYKCJ2HYBGAjJwTu3d1R+c4UrBfh0TAquqfKdZb0sgq7FasmAn+ASt+YhQJQ=="
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
    default = "55055bf3-7423-487f-8c47-6819712cdb71"
    description = "client id"
  
}

variable "client_secret" {
    type = string
    default = "Bre8Q~VExvd1gq5lRQsMX13jsGXL0YW-_l90~at-"
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
    name = "testwebapp5697582"
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
