variable "filename" {
  default     = "pets.txt"
  type        = string
  description = "the path of local file"
}

variable "content" {
  default     = "My favourite pet is mr.whiskers"
  type        = string
  description = "the content of the file"
}

variable "prefix" {
  default     = "mr"
  type        = string
  description = "the prefix to be set"
}

variable "separator" {
  default = "."
}

variable "length" {
  default     = "2"
  type        = number
  description = "length of the pet name"
}