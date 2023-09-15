#list
resource "random_pet" "my-pet" {
  prefix = var.prefix[0]
}

#map
resource "local_file" "my-pet" {
  filename = "pets.txt"
  content  = var.file_content["statement2"]
}