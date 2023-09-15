resource "local_file" "pet" {
  filename = var.filename[count.index]
  content  = "test"
  count    = length(var.filename)
}