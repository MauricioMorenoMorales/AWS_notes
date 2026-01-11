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

# Load balancers

- Los listeners son configuraciones que redirigen el trafico a target groups formados por instancias, son las difiniciones de como mueves la data
- Existen tres tipos de ELB< Classic, application y network, application son para HTTP y network todo lo que no es HTTP y es más rápido

# VPNS
- Una virtual private gategay es donde se conecta la vpn 
- Lon on premise se pueden asociar a una tabla o BPG

# Direct Connect
- ES un cable fisico para conectarte a AWS
- Primero te conectas a un Direct Connect DX location, esta tiene un customer router que recibe y un aws router que redirecciona
- Se te cobra por port hours y data transit

# VPC Peering
- Te permite comunicar distintos vpcs entre distintas o mismas regiones o incluso cuentas
- Tienes que configurar routing tables para esto

# Transit gateway
- Si tienes muchos vpcs comunicandose entre si usas VPC peering vas a necesitar una cantidad de conecciones altas, con un transit gateway todos se conectan a ese nodo y no necesitas hacer muchas conecciones, todas apuntan al transit gateway, se puede conectar a vpns, a servicios on premise incluso a otros transit gateways

# Cloud front
- es el servicio que te permite distribuir informacion a edge locations
- Tiene un origin que es el recurso principal que se distribuira
- La informacion esta durante un Time To Live TTL, por default es de 24 horas, los edge locations pueden funcionar como cache

# Lamda@edge functions
- Son funciones que corren en edge locations
- Las cloudfront functions reciven requests de un viewer
- Corren cuando cloudfront recibe un request de el viewer, se ehecutan antes de que cloudfront mande un request al origen, se ejecutan cuando cloudfront recibe una respuesta del viewer
- las cloudfront functions Se usan para funciones pequeñas tipo chache key normalization, header manipulation, url redirects o rewrites, request authorizations
- Lamgda@edge functions, son usadas con funciones de larga duracion, para configurar cpu y funciones de memoria, manejar dependencias de librerias externas, network dependent functions, file system o HTTP request access functions

# Global Accelerator
- Normalmente cuando tienes que conectarte a distintos nodos en distintos continentes vas a tener problemas de velocidad y puedes generar problemas en la experiencia de usuario
- Existen edge locations con global accelerator edge locations, el usuario no tiene que ir por el internet regular solo a travez de; AWS backbone network

# Route cincuenta y tres 
- Es un servicio manejado de aws y sus dnms, actua como registro de dominios, es un servicio global no especifico a una region
- Cuando tienes un dominio manejado por ellos, se guarda en una collection of dns records, estos se pueden guardar en una hosted zone (los servicios que usan el dns)
- haces records para direccionar a ciertos objetivos a tus dns

# Application recovery controller
- Se puede usar para direccionar a backups o rutas de emergencia
- Un recovery group abarca tanto la parte active y el standby

# Elastic block storage
- permite guardar informacion en bloques, en tu sistema aparecen como volumenes, pueden ser presentados como file system tambien, como un hard drive para tu sistema operativo, aqui tambien puedes hacer bootables y montables
- No estan attacheados a una EC2 son como discos duros externos, puedes cambiarlos entre instancias para transmitir informacion
- Los ec2 y ebs tienen que estar en la misma availability zone, para hacer eso tienes que usar snapshots, tambien se puede entre regiones
- Existen distintos volume types
- General purpose SSD gp2 gp3
- Provisioned IOPS SSD volumes: son los de mejor performance, para procesos criticos que requieren baja intermitencia
- Throughput Optimized HDD volumes
- Cold HDD volumes
- Magnetic: tienen mas espacio pero menor velocidad

# Instance store
- Es un storage temporal dentro del EC2 esta dentro de la misma maquina que corre la instancia, solo es usada para imformacion temporal que cambia rapido


# AWS EFS y FSx
- EFS solo funciona en linux no en windows
- se deployea en un vpc y permite compartir informacion entre distintos targets
- Existen distintos tipos de EFS, general purpose, elastic throughput mode, max I/O performance (input output), provisoned throughtput, bursting throughput

# FSx
- Te permite file storage y es manejado por aws, es similar a EFS, este funciona en windows a diferencia de EFS
- Existe FSx for lustre, este te permite high performance computing, como computacion cientifica
- FSx for NetAPP ONTAPP, te permite high performance store de linux windows y macOS
- FSx for open ZFS usa un sistema open source

# Bacckup vs disaster recovery
- El disaster recovery es una estrategia general que abarca mas conceptos en el que los backups son un subset pequeño
- Requieren un AWS Replication agent para trabajar en el disaster recovery, este leera a los source servers