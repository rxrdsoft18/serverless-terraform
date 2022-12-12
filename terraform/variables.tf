variable "instance_name" {
  default     = "ExampleAppServerInstance"
  type        = string
  description = "Value of the name tag for the EC2 instance"
}

variable "aws_region" {
    default     = "us-east-1"
    type        = string
    description = "The region in which the resources will be created"
}
