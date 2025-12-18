# VPCS
Las vpcs te ayudan a aislar servicios
- Las VPCS se hacen en regiones
- VPC < Region
- Por default las VPCs estan aisladas, pero se pueden comunicar si explicitamente se les permite
- TOdas las regiones tienen un default VPC con default configuration
- Las subnets pueden ser asociadas a una sola route table

# Internet gateways
- Las internet gateways permiten a las subnets de conectarse al mundo exterior
- Para hacer una public subnet, primero tienes que crear una Internet gateway en la region, crear una route table, tambien le tienes que dar una public IP a tu public subnet


# Subnets
- Una subnet es un grupo de IP addresses dentro de tu VPC
- Todos los vpcs tienen vpc routers
- El NAT Gateway se usa para conectar private subnets a public subnets para tener acceso a el internet, el NAT gateway se agrega en la public subnet, y las private subnets apuntan a el NAT gateway

## DNS in VPC
- Las IP addresses de las subnets pueden tener un domain name interno tipo "10.0.100.10.ec2.internal", puedes usar ambos valores, para resolver estos valores aws tiene un DNS service
- Por default solo Privates subnets tienen un domain name, las publicas (con public IP) no, para esto tienes que cambiar el "enableDnsHostnames"

# Security groups & NACLs
- Hay reglas inbound y outbound, existen dos tipos de firewalls uno stateless y otro statefull
- Stateless Firewall: Son firewalls en los que se tienen que poner las reglas Inbound Y outbound
- Las statefull mantienen trafico a la respuesta, no tienen que poneroutbound solo el inbound, y ya da por hecho el outbound del request
- Network Access Control List: Filtran el trafico entrando y saliendo de la subnet, No filtran trafico dentro de una subnet
- Los security groups son firewalls para recursos individuales, como instancias y load balancers, los security groups son Stateful y los NACL stateless
- Cada subnet en una VPC tiene que estar asociada a un Network ACL, las ACL se pueden asociar a multiples subnets pero las subnets solo a un ACL, por default los security groups tienen reglas que permiten todo el outbound traffico
- Network ACLs no filtran trafico destinado a los siguientes servicios Amazon DNS, Amazon Dynamic host configuration protpcol, Amazon EC2 instance metadata, Amazon ECS task metadata endpoints, License for Windows instances, Amazon Time Sync Service, REserved IP addresses used by default VPC Router