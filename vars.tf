variable "AWS_REGION" {
  default = "ap-northeast-1"
}

variable "PRIVATE_KEY_PATH" {
  default = "tokyo-region-key-pair"
}

variable "PUBLIC_KEY_PATH" {
  default = "tokyo-region-key-pair.pub"
}

variable "EC2_USER" {
  default = "ubuntu"
}
variable "AMI" {
  type = map(string)

  default = {
    ap-northeast-1 = "ami-0590f3a1742b17914"
    us-east-1 = "ami-0c2a1acae6667e438"
  }
}
