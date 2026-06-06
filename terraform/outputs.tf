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

# Load Balancer outputs
output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "ALB Zone ID"
  value       = aws_lb.main.zone_id
}

# Bastion output
output "bastion_public_ip" {
  description = "Bastion host public IP"
  value       = aws_instance.bastion.public_ip
}

# Multi-AZ Frontend IPs
output "frontend_az1_public_ip" {
  description = "Frontend AZ1 public IP"
  value       = aws_instance.frontend_az1.public_ip
}

output "frontend_az2_public_ip" {
  description = "Frontend AZ2 public IP"
  value       = aws_instance.frontend_az2.public_ip
}
