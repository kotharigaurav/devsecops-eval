# resource "aws_vpc" "main" {
#   cidr_block           = var.vpc_cidr
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = {
#     Name        = "${var.project_name}-vpc"
#     Environment = "dev"
#   }
# }

# resource "aws_subnet" "public" {
#   count                   = length(var.public_subnets)
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = element(var.public_subnets, count.index)
#   availability_zone       = element(var.azs, count.index)
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "${var.project_name}-public-${count.index + 1}"
#     "kubernetes.io/role/elb" = "1"  # for EKS LoadBalancers
#   }
# }

# resource "aws_subnet" "private" {
#   count             = length(var.private_subnets)
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = element(var.private_subnets, count.index)
#   availability_zone = element(var.azs, count.index)

#   tags = {
#     Name = "${var.project_name}-private-${count.index + 1}"
#     "kubernetes.io/role/internal-elb" = "1"  # for internal services
#   }
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "${var.project_name}-igw"
#   }
# }

# resource "aws_eip" "nat" {
#   vpc = true
#   tags = {
#     Name = "${var.project_name}-nat-eip"
#   }
# }

# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public[0].id
#   depends_on    = [aws_internet_gateway.igw]

#   tags = {
#     Name = "${var.project_name}-nat-gw"
#   }
# }

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = {
#     Name = "${var.project_name}-public-rt"
#   }
# }

# # Associate public subnets
# resource "aws_route_table_association" "public_assoc" {
#   count          = length(aws_subnet.public)
#   subnet_id      = aws_subnet.public[count.index].id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat.id
#   }

#   tags = {
#     Name = "${var.project_name}-private-rt"
#   }
# }

# # Associate private subnets
# resource "aws_route_table_association" "private_assoc" {
#   count          = length(aws_subnet.private)
#   subnet_id      = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.private.id
# }
