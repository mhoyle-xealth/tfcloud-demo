terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "matthoyle-xealth"

    workspaces {
      name = "infra-staging"
    }
  }
}
