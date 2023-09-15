terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~>2.4.0"
    }
  }
}


resource "local_file" "pet" {
  filename = each.value
  content  = "birds"
  for_each = toset(var.filename)
}