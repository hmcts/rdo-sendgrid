variable "configs" {
  description = "SendGrid Configuration"
  type        = list(map(string))
}

variable "env" {
  description = "SendGrid Configuration"
  type        = string
}