variable "name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "src_dir" {
  description = "The directory containing the source code"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
  default     = "nodejs20.x"
}

variable "handler" {
  description = "The function entrypoint in your code"
  type        = string
  default     = "index.handler"
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds"
  type        = number
  default     = 5
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function"
  type        = map(string)
  default     = {}
}
