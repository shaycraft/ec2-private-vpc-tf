terraform {
  cloud {
    organization = "mr-gav-meow"

    workspaces {
      name = "ec2-private-vpc"
    }
  }
}
