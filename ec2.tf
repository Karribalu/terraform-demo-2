resource "aws_instance" "web1" {

    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"

    # VPC
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

    # the Public SSH key
    key_name = "${aws_key_pair.tokyo-region-key-pair.id}"

    # nginx installation
    provisioner "file" {
        source = "nginx.sh"
        destination = "/tmp/nginx.sh"
    }

    provisioner "file" {
    	source = "ansible.sh"
	destination = "/tmp/ansible.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/nginx.sh",
	    "chmod +x /tmp/ansible.sh",
	    "sudo /tmp/ansible.sh",
            "sudo /tmp/nginx.sh"
        ]
    }

    connection {
	host = self.public_ip
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }
}

resource "aws_key_pair" "tokyo-region-key-pair" {
    key_name = "tokyo-region-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}
