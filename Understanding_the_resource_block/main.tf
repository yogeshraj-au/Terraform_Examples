resource "local_file" "pet" {
  filename = var.filename
  #content  = "my favourite pet is ${random_pet.my-pet.id}"#implicit dependency
  content         = data.local_file.dog.content
  file_permission = "0700"

  lifecycle {
    create_before_destroy = false
    #prevent_destroy = true
    #ignore_changes = all
  }

  depends_on = [
    random_pet.my-pet #explicit dependency   
  ]
}

data "local_file" "dog" {
  filename = "animals.txt"
}

resource "random_pet" "my-pet" {
  prefix    = var.prefix
  separator = var.separator
  length    = var.length
}