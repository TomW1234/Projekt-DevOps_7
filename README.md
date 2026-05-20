Popis souborů
providers-9.tf obsahuje AWS provider s regionem z proměnné a navazuje na původní strukturu projektu.

variables-13.tf definuje region, název projektu a CIDR rozsahy pro VPC i všechny čtyři subnety, protože oproti původní verzi už síť nevychází z existující VPC.

vpc.tf vytváří celou síťovou vrstvu: VPC, internet gateway, dvě public subnety, dvě private subnety, Elastic IP, NAT gateway, public/private route tables a jejich asociace. To nahrazuje původní soubor, který jen načítal default VPC a všechny subnety bez rozlišení.

securitygroups-10.tf vytváří security group pro ALB s přístupem z internetu na port 80 a security group pro ECS tasky, které povolují port 80 jen od ALB. To zachovává stejnou logiku jako v tvých původních security groups, jen už je navázaná na nově vytvořenou VPC.

alb-2.tf vytváří veřejný Application Load Balancer v public subnets, target group typu ip a HTTP listener na portu 80 s health checkem na /. Tím přímo plní část zadání o veřejně dostupném nginxu přes load balancer.

iam-6.tf vytváří ECS task execution roli a připojuje managed policy AmazonECSTaskExecutionRolePolicy, což je čistší než původní široká inline policy.

ecs-service-5.tf vytváří ECS cluster, task definition s nginx:alpine, 256 CPU, 512 MB memory a ECS service s desired_count = 1 na Fargate ve private subnetech bez public IP. Oproti původnímu souboru tak opravuje image, velikost tasku i počet běžících tasků.

state-11.tf ponechává backend do S3, outputs.tf přidává výstupy pro ALB DNS, VPC ID a subnet IDs a terraform.tfvars.example ukazuje ukázkové hodnoty proměnných pro rychlé spuštění.
