#################################################################
#                             _`		                            #
#                          _ooOoo_		                          #
#                         o8888888o		                          #
#                         88" . "88		                          #
#                         (| -_- |)		                          #
#                         O\  =  /O		                          #
#                      ____/`---'\____		                      #
#                    .'  \\|     |//  `.		                    #
#                   /  \\|||  :  |||//  \		                    #
#                  /  _||||| -:- |||||_  \		                  #
#                  |   | \\\  -  /'| |   |		                  #
#                  | \_|  `\`---'//  |_/ |		                  #
#                  \  .-\__ `-. -'__/-.  /		                  #
#                ___`. .'  /--.--\  `. .'___		                #
#             ."" '<  `.___\_<|>_/___.' _> \"".		              #
#            | | :  `- \`. ;`. _/; .'/ /  .' ; |	              #
#            \  \ `-.   \_\_`. _.'_/_/  -' _.' /	              #
#=============`-.`___`-.__\ \___  /__.-'_.'_.-'=================#
#                          `= --= -'                            #

terraform {
  required_version = ">= 1.2.6"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.18.0"
    }
  }
  
  backend "azurerm" {
    # resource_group_name   = "sqlapp-dev-eastasia-01-tfstate-rg"
    # storage_account_name  = "sqlappdeveastasia01state"
    # container_name        = "sqlapp-dev-eastasia-01-tfstate-container"
    # key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}