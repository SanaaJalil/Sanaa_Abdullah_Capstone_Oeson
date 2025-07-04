# outputs.tf placeholder

output "jenkins_public_ip" {
  description = "Public IP of the Jenkins EC2 instance"
  value       = aws_instance.jenkins.public_ip
}

output "k8s_node_1_public_ip" {
  description = "Public IP of Kubernetes Node 1"
  value       = aws_instance.k8s_node_1.public_ip
}

output "k8s_node_2_public_ip" {
  description = "Public IP of Kubernetes Node 2"
  value       = aws_instance.k8s_node_2.public_ip
}
