terraform {
  cloud {
    organization = "mr-gav-meow"

    workspaces {
      name = "api-gateway-private-vpc"
    }
  }
}
