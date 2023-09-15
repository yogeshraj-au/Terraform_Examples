variable "filename" {
  type = set(string)
  default = [
    "birds.txt",
    "animals.txt",
    "forest.txt",
    "beach.txt"
  ]
}