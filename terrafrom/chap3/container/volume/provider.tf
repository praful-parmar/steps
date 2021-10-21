terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker" //provide source
      version = "~> 2.12"            // allow version 2.12 to 2.max 
    }
  }
}