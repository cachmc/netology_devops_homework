###vars for task 5

variable "anything_string" {
  type        = string
  default     = "asdasddvgsfgfw32434132qerwfegq2d13gfvwcxq23d243t5y57j68umnbvc/e.,fmwr2k3"
  description = "любая строка"

  validation {
    condition     = can(regex(".*[A-Z].*", var.anything_string)) == false
    error_message = "Variable contains capital letters"
  }
}

variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })

    default = {
        Dunkan = true
        Connor = false
    }

    validation {
        error_message = "There can be only one MacLeod"
        condition = (var.in_the_end_there_can_be_only_one.Dunkan == true && var.in_the_end_there_can_be_only_one.Connor == false) || (var.in_the_end_there_can_be_only_one.Dunkan == false && var.in_the_end_there_can_be_only_one.Connor == true) ? true : false
    }
}
