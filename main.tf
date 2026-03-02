# 1. THE REGION
provider "aws" {
  region = "ap-south-1" # Mumbai data center for low latency
}

# 2. THE BLUEPRINT (Launch Template)
# This tells AWS exactly how to build a new Node.js server if traffic spikes.
resource "aws_launch_template" "shikshaflow_app" {
  name_prefix   = "shikshaflow-node-server"
  image_id      = "ami-0f58b397bc5c1f2e8" # Ubuntu 24.04 in Mumbai
  instance_type = "t2.micro"              # Free-tier eligible
  key_name      = "myServer"              # Your existing SSH key

  tags = {
    Name = "ShikshaFlow-Worker-Node"
  }
}

# 3. THE HORIZONTAL SCALER (Auto Scaling Group)
# This manages the number of active servers based on your rules.
resource "aws_autoscaling_group" "app_cluster" {
  desired_capacity    = 2 # Start with 2 servers running normally
  max_size            = 5 # If the 8:00 AM rush hits, scale up to 5!
  min_size            = 1 # If it's 3:00 AM and nobody is online, drop to 1 to save money.
  
  # Connect it to the blueprint above
  launch_template {
    id      = aws_launch_template.shikshaflow_app.id
    version = "$Latest"
  }

  availability_zones = ["ap-south-1a", "ap-south-1b"] # Spread servers across two different buildings just in case one loses power
}

# 4. THE TRAFFIC COP (Application Load Balancer)
resource "aws_lb" "front_door" {
  name               = "shikshaflow-load-balancer"
  internal           = false
  load_balancer_type = "application"
  
  # Note: In a real deployment, you map this to your specific AWS Subnets and Security Groups
  # subnets         = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}