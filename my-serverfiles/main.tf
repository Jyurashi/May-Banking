resource "aws_instance" "test-server" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = "Babuckey"
  vpc_security_group_ids = ["sg-040866a66b047f0df"]
  connection {
     type 		= "ssh"
     user		= "ubuntu"
     private_key	= file("./Babuckey.pem")
     host		= self.public_ip
}

provisioner "remote-exec" {
    inline = ["echo 'wait to start the instance' "]
}
tags = {
  Name = "test-server"
}
provisioner "local-exec" {
    inline = " echo ${aws_instance.test-server.public_ip} > inventory "
}
provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Banking-Project/my-serverfiles/finance-playbook.yml"
}
}
