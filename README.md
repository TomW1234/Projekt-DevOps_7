http://lekce7-nginx-demo-alb-1629758711.eu-central-1.elb.amazonaws.com/

--------------------------------------------------------------------------

Popis souborů:

providers-9.tf obsahuje AWS provider s regionem z proměnné a navazuje na původní strukturu projektu.

variables-13.tf definuje region, název projektu a CIDR rozsahy pro VPC i všechny čtyři subnety

vpc.tf vytváří celou síťovou vrstvu: VPC, internet gateway, dvě public subnety, dvě private subnety, Elastic IP, NAT gateway, public/private route tables a jejich asociace.

securitygroups-10.tf vytváří security group pro ALB s přístupem z internetu na port 80 a security group pro ECS tasky, které povolují port 80 jen od ALB. 

alb-2.tf vytváří veřejný Application Load Balancer v public subnets, target group typu ip a HTTP listener na portu 80 s health checkem na /. 

iam-6.tf vytváří ECS task execution roli a připojuje managed policy AmazonECSTaskExecutionRolePolicy.

ecs-service-5.tf vytváří ECS cluster, task definition s nginx:alpine, 256 CPU, 512 MB memory a ECS service s desired_count = 1 na Fargate ve private subnetech bez public IP. 

state-11.tf ponechává backend do S3, outputs.tf přidává výstupy pro ALB DNS, VPC ID a subnet IDs a terraform.tfvars.example ukazuje ukázkové hodnoty proměnných pro rychlé spuštění.
