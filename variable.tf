variable "region" {
    description = "Region where to create EC2 server"
    default = "us-west-2"
}

variable "instance_type"{
    description = "EC2 instance type"
    default = "t2-micro"
}
