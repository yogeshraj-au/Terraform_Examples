#list
variable "prefix" {
  type    = list(any)
  default = ["mr", "mrs", "sir"]
}

#map
variable "file_content" {
  type = map(any)
  default = {
    statement1 = "we love pets!"
    statement2 = "we love animals!"
  }
}

#list of a type(the list will only accept string)
variable "prefix-0" {
  default = ["Mr", "Mrs", "Sir"]
  type    = list(string)
}

#list of a type(the list will only accept number)
variable "prefix-1" {
  default = ["1", "2", "3"]
  type    = list(number)
}

#map of a type(the map will only accept string)
variable "cats" {
  default = {
    "color" = "brown"
    "name"  = "bella"
  }
  type = map(string)
}

#map of a type(the map will only accept number)
variable "pet_count" {
  default = {
    "dogs"     = "3"
    "cats"     = "1"
    "goldfish" = "2"
  }
  type = map(number)
}

#set(it won't allow duplicate values)
variable "prefix-2" {
  default = ["Mr", "Mrs", "Sir"]
  type    = set(string)
}

variable "fruit" {
  default = ["apple", "banana"]
  type    = set(string)
}

variable "age" {
  default = ["10", "12", "15"]
  type    = set(number)
}

#objects
variable "bella" {
  type = object({
    name         = string
    color        = string
    age          = number
    food         = list(string)
    favorite_pet = bool
  })
  default = {
    name         = "bella"
    color        = "brown"
    age          = 7
    food         = ["fish", "chicken", "turkey"]
    favorite_pet = true
  }
}

#tuple
variable "kitty" {
  type    = tuple([string, number, bool])
  default = ["cat", 7, true]
}