output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = aws_subnet.private.id
}

output "frontend_instance_public_ip" {
  description = "Frontend EC2 public IP"
  value       = aws_instance.frontend.public_ip
}

output "frontend_instance_public_dns" {
  description = "Frontend EC2 public DNS"
  value       = aws_instance.frontend.public_dns
}

output "backend_instance_private_ip" {
  description = "Backend EC2 private IP"
  value       = aws_instance.backend.private_ip
}

output "database_instance_private_ip" {
  description = "Database EC2 private IP"
  value       = aws_instance.database.private_ip
}

# NAT Gateway outputs
output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.main.id
}

output "nat_eip" {
  description = "NAT Gateway Elastic IP"
  value       = aws_eip.nat.public_ip
}
