## !!!!!!!!!!!!!!!!!!!!!!!!!! Repasar EBS

# Edge Locations vs local zones
- Ambos ayudan a estar mas cerca de los end users para mejorar latencia
- Local zones son extensiones de regiones
- Local zones tienen su infraestructura aislada pero conectada a un padre en la region AWS
- Local zones proveen acceso a un subset de servicios como EC2 y EBS
- Edge locations estan mas disperzos, no tienen casi servicios mas que CDN y no proveen servicios computacionales

# AWS Account Setup
- Cuando creas una cuenta de aws lo primero que pasa es que se crea un root user con tu correo electronico

# VPCS
Cada VPC tiene un CDR block, que es un rango de IPS, que puden ir desde /16 y /18
Existen custom vpcs hechas por el usuario y default VPC hechas por aws
Las defaults subnets son accesibles por internet
Tiene default security groups

# EC2
Existen varios tipos de instancias en AWS, las categorias son las siguientes
- General Purpose
- Compute Optimized
- Memory Optimized
- Storage Optimized
- GPU Instances

Existen los Amazon Machine Images, que te establecen la informacion de el sistema operativo y dependencias que se van a utilizar
El ciclo de vida de una instancia EC2 es la siguiente
Launch -> Pending -> Running | Shutting down -> Terminated
             |               v   ^  ^
             ------------> stop --  |
                            |       |
                            v       |
                          Stopped - |

Las vpcs se asignan a un security group

Se suelen guardar EBS dentro de vpcs/availability_zones, tambien se hacen EBS snapshots que son copias de las bases de datos creadaso

El load balancer puede apuntar a distintas availability zones

Existen los Launch template, los cuales te ayudan a desplegar EC2 con distintas configuraciones

EC2 Instance Placements:
Existen Cluster Placement group, te ayudan a poner instancas en el mismo rack o edificio o servidor para optimizar algunos procesos
Partition Placement Group, Agrupa los servicios en distintas particiones en distintos hardwares
Spread Placement Group, los mantiene separados en distintos racks para evitar problemas de hardware

Existen 6 formas de pagar las opciones
- En demanda: Ir cada dia a una cafeteria y la pides cuando quieres o crees que necesitarias hacerlo
- SpotL En ciertos momentos comprar cuando encuentres 90% de descuento
- Saving Plans: te comprometes a comprar diariamente un café durante un mes recibiendo con esto menores precios
- Reserved Instances: Compras una maquina entera de café en la cafeteria para ti que puedes usar como quieras
- Dedicated hosts: Consigues exclusividad, tienes una mesa para ti solo dentro del negocio
- Dedicated instances

# Route 53
- Administra DNS, te permite comprar tus domains, como Goddady

Hosted Zones: Aplica un conjunto de servidores bajo el mismo url
- Es un servicio global

Beneficios usar CLI: Eficiencia, tiene mas configuration obtions, mejor colaboracion, y es mas facil el troubleshooting

Security Group ID
sg-0b2dea5f54934fa34

subnet-ec-2-1:
subnet-012b9c4c513794581

# AWS CloudFormation
Esto te ayuda a tener infraestructura como codigo, esto es como tener un plano para saber exactamente que construir, en vez de estar paso a paso a ciegas haciendo cambios, los pasos son los siguientes cuando haces cambio

Editas template -> Actualizas stack -> Actualizas el Change Set -> Aplica los cambios

Los beneficios son los siguientes:
- Infraestructura como Codigo
- Consistent and Repeatable Deployments
- Version control
- Resource tracking
- Cost and Time Efficiency

Tambien se puede usar AWS CodeCommit que es un servicio de control de versiones completamente administrado por Amazon Web Services.
Básicamente funciona como GitHub o GitLab, pero dentro del ecosistema de AWS.

# CDK
Te permite hacer lo mismo que cloud formation pero aun mas personalizado te permite
- Declarative approach
- Component reusability
- AWS Construct Library
- Automated Synthesis
- Environment Agnosticism

El flujo comun del CDK Pipeline es el siguiente

AWS Code Commit -> AWS CodeBuild -> AWS CloudFormation -> (S3, EC2, RDS, VPC)

# Subnets
- En una VPC tienes tu subnetting, Routes tables, Firewalls NACLS y Security groups
- Las VPCS estan dentro de una region obligatoriamente
- Por defecto los servicios no tienen permiso para hablar con otros recursos en otras vpcs
- El CIDR que es el rango de IP addresses tambien define que recursos la VPC puede usar
- El CIDR block puede ser de cualquier tamaño entre /16 y /28
- Hay 2 tipos de vpcs custom y default

- Cada availability zone te da un VPC por region, /16 IPv4 CIDR, /20 default subnet in each availability zone
- Las vpcs van a tener un internet gateway y una ruta que apunta a todo el trafico

Region > VPC > Availability zone

- Una subnet es un grupo de IP addresses dentro de tu VPC, estas viven dentro de una sola Availability Zone
- Las subnets tienen que estar dentro de un rango de CIDR
- Las subnets tienen que estar entre /16 y /28
- Los primeros 4 IP addresses de una subnet estan reservados y no pueden ser usados, el ultimo IP de una subnet esta reservado a el broadcast address
- Las subnets no pueden overlap con otras subnets en la vpc, tambien permiten un IPv6 opcional, pueden ser configuradas solo con IPv6 y pueden comunicarse con otras subnets in el VPC

# Routing VPCs
- Cada vpc tiene un VPC router, el cual tiene una interfaz en el IP Address + 1 de la subnet, este permite conectarse afuera de la vpc
- Multiples subnets pueden asociarse a una route table, una route por defecto puede agregarse a cada vpc
- Cada subnet esta asociada a una route table

# Internet Gateway
- Los internet gateways estan atacheados a un vpc, si no hay internet gateway todas las subnets estaran encapsuladas
- Las subnets primero buscan dentro de la VPC si no encuentran algo van a el gateway
- Los gateways tienen un IP publico, aws una vez recibiendo info convierte esa IP publica y manda a el private IP
En resumen
- Enable resources to connect internet
- Internet Gateways attach to a VPC and are region resilient
- VPC only have max 1 internet gateway and a internet gateway can only be attached to max 1 VPC
- A subnet is public once a default route points to the internet gateway in the VPC

# NAT Gateway
- Pueden existir Internal servers privados que no pueden ser accesidos, estos acceden a internet por NAT Gateways
- Primero se crea un Gateway esta se asocia a una subnet publica -> Gateway, y la private subnet se conecta a la public subnet -> NAT -> Gateway
- Las NAT Gateways usan Elastic IPs

# Private vs Public
- Un ejemplo de un servicio publico es un web server, el web server esta en la public subnet
- La base de datos debe de estar en una private subnet

# Elastic IP
- Tenemos que evitar que las IPs publicas tengan que cambiar, en especial cuando reiniciamos servicios, son IPs estaticas, es una IPv4, estas se guardan para tu cuenta, se pueden cambiar, por ejemplo haces mantenimiento a un servidor, pero tienes otro, se puede mandar ese IP a otro servidor
- Puedes usar un Elastic IP gratis los demas tendran un cargo adicional
- Son especificas a una región
- Tienes que alocar primero luego asociar

# Security Groups & NACLs
- Los firewalls monitorean el trafico y solo aceptan dependiendo unas reglas, las cuales son inbound y outbound
- Stateles Firewalls: Tienen que ser configurados para permitir ambos inbound y outbound traffic
- Stateful: son lo suficientemente inteligentes para saber que request y response permanecen a la misma coneccion, si un request es permitido su response es permitida tambien en un stateful firewall
- Network Access Control List NACL: Filtra el trafico entrando y saliendo de una subnet, pero no lo hace dentro de la subnet, son stateless firewalls, sus reglas tienen que ser establecidas para ambos escenarios
probando la comididad de esta posicion
- Cuando creas un security group permite ciertos tipos de trafico
- Todos los security groups permiten el trafico, no hay deny options para estos grupos
- NACL puede negar y permitir trafico
- Puedes asignar multiple security groups en un solo recurso
- Algunos security groups tienen por defecto el permitir todo el trafico
- Cada subnet dentro de un VPC tiehe que estar asociado con un network ACL
- Puedes asociar un network ACL con multiples subnets, sin embargo una subnet solo puede estar asociada con una network ACL al mismo tiempo
- ACLs no filtran trafico destinado y de los siguientes servicios
  - Amazon Domain Services
  - Amazon Dynamic Host Configuration Protocol
  - Amazon EC2 instance metadata
  - Amazon ECS task metadata endpoints
  - License activation for windows instances
  - Amazon Time Sync Service
  - Reserved IP addresses used by default vpc Routers

- probando la comodidad de esta cosa si siento que el 10 es el mas comodo de todos las posiciones
- 0.0.0.0/0 significa todas las IPs

# VPC Peering
Los vpcs no pueden hablar entre si, pero si necesitas hacer que hablen entre si usas un VPC Peering, que les permite conecciones entre ellos
No tienen costos, si se transfiere data dentro un Availability zones es gratis, pero fuera de Availability Zones si se cobra
No puedes hablar a un tercero pasando por un segundo vpc1 -> vpc2 -> vpc3 /= vpc1 -> vpc3
- VPC peering is not transitive

# TPS
- VPC isolates computing resources from other computing resources available in the cloud
- VPCs are isolated to a region
- VPC CIDR block defines the IP addresses a VPC can use
- VPCs have optional secondary IPv4 CIDR block as well as IPv6 CIDR block
- Every region has a Default VPC with default subnets, Security Groups and NACLs
- The CIDR block for the default VPC is 17.31.0.0/16
- Each VPC has a router for routing traffic between subnets and to/from the VPC
- The router has an interface in each subnet, reachable via its network+1 address
- Route tables are sets of rules (routes) for the router to forward network traffic
- Each route matches a packet's destination IP to target for forwarding
- Packets are forwarded to the specified route target upon matching a destination
- Default route tables include a local route (two with IPv6 enabled)

Internet Gateway
- Internet gateways attach to a vpc and are region resilient
- VPC can only have max 1 internet gateway and a Intergnet gateway can only be attached max to 1 VPC
- A subnet is maded public once a default route points to the internet gateway in the VPC

NAT Gateway
- Solo permiten salida no entrada, se usa para subnets privadas, bases de datos etc
- Se deployean en public subnets con Elastic IPs para conectividad internet
- Require one NAT Gateway per AZ for reliability
- Costs incurred hourly for availability and data processed
- surpots up to 5Gbps bandwith, scales automatically to 100GBps

Security
- ACLs filter trafic and leaving subnet
- Network ACLs are stateles firewalls
- Security groups act as firewalls foor individual resources such as EC2 NICs and other network objects
- Security Groups are stateful firewalls
- Security groups only allow traffic, NACLs have allow and deny
- Every VPC needs to have a network ACL
- You can associate network ACL with multiple subnets

# IAM
Puedes crear roles en IAM para servicios y cuentas

Amazon Security Token services
  - AssumeROle: Returns temporary credentials to access AWS Resources
  - AssumeRoleWithSAML: Returns temporary credentials for users who have been authenticated via SAML
  - AssumeRoleWithWebIdentity: Returns temporary credentials for users who have been authenticated via web identity provider (Google, Facebook)
  - DecodeAuthorizationMessage: Decodes additional information from an error when a request to AWS fails
  - GetCallerIdentity: Returns details about the IAM User or Role that made the API call
  - GetSessionToken: Returns credentials for users that have MFA enabled

- Implement Multi Factor authentication for all users
- Create IAM users for individuals or applications
- Assign permissons to users/groups/roles
- Roles are temporary
- Trust policies specify who can assume a role
- PassRole permissions allow users to assign roles to AWS services
- Via API you use AssumeRole to assume role
- If MFA is enabled utilize GetSessionToken

# EC2
- On demand Pricing: pagas lo que usas
- Spot Pricing: Pagas descuentos, pueden tener interrupciones, es optimo para aplicaciones que necesitan computing prices bajos
- Resserver Pricing: Te permite ahorrar si estableces que usaras un servicio unos años
- Dedicated Hosts: Tienes un servidor solo para ti
- Dedicated Instance: Tienes un servidor completo para ti, pero en este punto pueden ser varios servidores

Tipos de storage
- Existen los Instance Stores: son temporales si se mueven se pierden, tienen buen performance
- ECD With EBS: son persistentes, dentro de un vpc
- EFS: puedes montar un sistema de archivos, es simple, es costo-efectivo, tiene buena escalabilidad, durabilidad y disponibilidad, y es accesible

EC2 Instance Placements
- Cluster Placement Group, se guardan las instancias de manera cercana en el mismo Rack, no tienen que viajar tanto para comunicarse entre si
- Partition Placement Group: Se guardan en distintas particiones dentro de un rack, hay mas tolerancia a caidas
- Spread Placement Group: se guarda en distinto hardware para evitar problemas

User Data
Cuando empiezas una istancia, le puedes dar un startup script, que automatiza la instalacion de paquetes y esto te permite ahorrar tiempo, tiene que ser Base64 encoded, tiene size limitation, Ejecuta automatic decoding, opaque treatment, IMpacta el boot time
Estos se ejecutan con root privilege

# EBS
- Elastic block store guarda objetos, se presentan ante tu sistema operativo como volumenes, puedes montar file systems y hacer boot en ellos
- breaks data in blocks each with unique identifier
- Are presented as volumes
- You can boot data
- To copy data to diferents AZ you need to create snapshots
- Pagas por GB por mes
- Puede mover data a distintas EC2 instances facilmente
- Los EC2 pueden estar attacheados a distintos EBS
- Cada ebs es asignada a un availability zone, no se puede conectar un EC2 a un EBS en una distinta AZ
- Si necesitas compartir informacion entre availability zones creas Volume snapshots
Volume Types
  - General purpose SSD gp2/gp3: Se guardan en solid diks, buscan tener buen precio y performance, se usa en la mayoria de workloads, gp3 son los ultimos y mas baratos,, GP2 son los default, son buenos para mantener un tamaño grande de almacenamiento
  - Provisoned IOPS SSD volumes: Igual SSD, tienen highest performance, especializados en Throughput-intensive processes, 
  - Thorughput Optimized HDD volumes
  - Cold HDD volumes
  - Magnetic volumes: se suelen usar para cold storage

# Instance Store Volumes
- Son discos attacheados a la computadora, se usa para informacion variable que no va a ser guardad por siempre, son temporales pero no dependen de la EC2 para mantenerse, el problema puede pasar si el EC2 cambia de Host alli se pierde la data
- Estas se encuentran en instance types mas caras, no en micro o nano,
- Algo que puede hacer que se mueva tu instancia no es necesariamente un reboot de hecho es algo raro, algo que si puede hacerlo es pararlo completamente

# EFS
- Soporta NFSv4 Protocol, con esto creas un sistema de archivos que puede ser conectado remotamente por otros sistemas, solo funciona basado en linux, puede tener varias EC2 conectadas al mismo tiempo
- No soporta windows
- Pueden estar montadas en dinsintas instancias EC2 a la vez
- Mount targets get IP addresses from the subnets they are mounted
- There are standard and One Zone
- Can be mounted but not booted
- EFS has two different modes: General purpose, performance and Elastic throughput
- Estan dentro de una vpc, y tiene que ser configurada con un Mount Target, una IP Address, los EC2 se conectan al EFS especificando la IP del EFS
Existen
  - Standard Storage Classes
  - One Zone Sturage classes
Tambien
  - Max I/O Performance Mode → optimiza el sistema de archivos para alto rendimiento y miles de conexiones simultáneas.
  - Provisioned Throughput Mode → te permite asignar manualmente el throughput independiente del tamaño del sistema de archivos.
  - Bursting Throughput Mode → el throughput varía automáticamente según el tamaño del sistema de archivos, con ráfagas para picos temporales.

Se pueden usar los comandos
> $ sudo dnf -y install amazon-efs-utils: te permite instalar las utilidades
> $ sudo mount.efs efs:id /directory: te permite montar el sistema de archivos en una direccion


# S3
- No se puede hacer boot en S3
- Objects are files
- Buckets are folders for objects
- Tienen que ser unicas a través de todo AWS
- EL maximo de tamaño de un archivo son 5tb
- Se puede hacer multi part upload
- Storage classes are set on upload using the x-amz-storage-class header but can be changed later
Storage classes
  - Standard: 99.999 durability, se distribuyen en distintas availability zones
  - S3 Standard-IA: Es informacion que no es accedida frecuentemente, charged per GB
  - S3 One Zone IA: los objetos no se replican en distintas AZ, menor costo por GB
  - S3 Glacier Instant
  - S3 Glacier Flexible
  - S3 Glacier Deep Archive
  - S3 Intelligent-Tiering

Versioning
  - Se usa para guardar versiones de cada elemento si se llega a borrar alguno
  - Pueden haber 3 estados en una bucket, unversioned, versioned enabled y versioned suspended


# ACL and REsources policies
  - Las buckets solo son accesibles en un inicio al creador y al Root User
  - Las bucket policies establecen quien tiene acceso a las buckets y que acciones van a poder hacer se componen de un objeto

```json
{
  "Version": "Nombre de la version",
  "Statement": [
    {
      "Sid": "Un nombre arbitrario",
      "Principal": { // Dice quien tiene acceso, puede ser tipo objeto o "*"
        "AWS": [
          "arn:aws:iam::112233:user/john doe"
        ]
      },
      "Effect": "Allow|Deny",
      "Action": ["s3:GetObject"],
      "Resource": [] // ARN de las buckets que van a ser usadas

    }
  ]
}
```


Tambien se puede poner en condicion, gente que venga de un IP, o permitir acceso a personas a buckets de cierta carpeta solamente

El "*" no solo significa que todos en tu cuenta tienen acceso si no todos en todos los servicios de aws incluso no autenticados

Las buckets y los servicios en un principio son cerrados, se tienen que abrir explicitamente al mundo para mantener seguridad

Las diferencias entre IAM policies y resource policies
  - IAM policies estan attacheadas a un usuario y dicen que puede hacer
  - Resource policies, determina quien puede hacer modificaciones a este recurso
  - El IAM policy y resource policy tienen que ambos permitir acceso a las personas para poder entrar

S3 ACLs
- Son legacy access control mechanisms que precedian IAM, no son recomendadas usar ahorita, son inflexible y solo dan una pequeña cantidad de reglas


- S3 se puede usar para guardar static web hosting

# Encryption
Scramble information so that only authorized parties can understand the information
Estos se ocupan normalmente en s3 en 3 momentos, cuando haces upload y download, esto se le llama In transit, y usa SSL y TLS
Encryption at rest: significa que los datos están cifrados mientras se encuentran almacenados (es decir, en el disco físico de AWS), no solo cuando viajan por la red.

Client-Side Encryption
Server-Side Encryption: Este es el que se usa en S3, usa SSE-S3 para amazon managed keys, SSE-C para customer proided keys, y SSE-KMS para key management services

> SSE-S3: Crea una llave para cada objeto todo esto se hace automaticamente
> SSE-KMS: Funciona igual a SSE-S3 pero guarda la llave en KMS
> !!!!!!!!!!!!!! Estudiar KMS
> SSE-C, nosotros manejamos las llaves, subimos la llave a S3 y alli se encripta todo

# Pre-Signed URLs
- Las presigned urls tienen embedidas un login especifico para que ciertas personas puedan entrar al servicio

Tienes que generar las llaves -> luego usarlas

Encryption occurs on a per object basis (different object can use different type of encryption)
A default encryption method can be configured on a bucket

SI la persona que creo la presigned-url no tiene acceso al recurso, la url tampoco la tendrá xd

# Access Points
Cada rol tiene un url que apunta a un tipo de servicio, developers, admins, infra
- LAs access Point policies tienen que aplicarse al access point tanto a la bucket

# S3 Access Logs
- Se logea informacion sobre quien pide data a los s3 buckets

# S3 events
- Cuando pasa una accion se pueden trigerear eventos y usarlos en otros servicios, notificaciones, lambda, SQS, event bridges

# Load balancing --------------------

- AWS manages the service, is a managed service
- Load balances distributes multiple servers using a single DNS entry
- It can load balance traffic to EC2 Instances, Lambda Functions, ECS tasks and IP addresses
- It can distribute traffic to servers in different AZs for high availability
- Load Balancers can be public or private
- A target group is used to route requests to one or more registered targets such as EC2 instances
  - Dependiendo9 una url redirecciona a un servico base de datos o lambda
- A listener is a process that checks for connection requests using protocol and port that you configure
  - Aqui es donde entra la data y el load balancer decide a donde redireccionarla
- Cross-Zone load-balancing allows equal distribution of traffic across instances in all AZs
  - Any questions about inbalance of traffic Cross-Zone load-balancing is usually the answer
- When connections draining is enabled the load balancer stops new requests to deregistering instances and maintains existing connections

- Connection draining: es deregistrar una instancia del load balancer, y asi se apaga una instancia sin causar problemas, se terminan todas las conecciones que se tenian anteriormente

- Application Load Balancer
  - Operates at Layer 7
  - Is HTTP/HTTPS aware
  - Should be used for any web-based applications
  - Can load-balance based on varios HTTP properties (URL Path, Hostname, HTTP headers, query parameters)
  - Can perform HTTP Redirects
  - Works with HTTP/HTTPS/WebSockets
  - SSL terminates on the load-balancer
- Network Load Balancer
  - Faster than application Load balancer
  - Operates at layer 4
  - Load balances TCP/UDP
  - Great for non-HTTP traffic
  - Faster than Application Load Balancer
  - Supports static IP for Load Balancer
Gateway Load Balancer
  - Ayuda a integrar firewalls, policies y otros servicios relacionados
  - Helps deploy scale and manage third party virtual appliances (firewalls, intrusion detection/prevention systems) in your VPC
  - Routes traffic to virtual appliances tha tinspect filter or modify it based on predefined policies before forwarding it
  - Operates at layer 3

Auto Scaling group
- Auto scaling Group allows to scale number of EC2 instances based off of metrics
- No extra cost, only pay for EC2 instances
- An AWS launch Template specifies EC2 instance launch specifications, entre ellos se configura el auto scaling, including the AMI instance type, security groups and block device mappings
- Scaling
  - Predictive Scaling: Uses machine learning to predict traffic patterns and scale your Auto Scaling group, proactively in anticipation of changes
  - Dynamic Scaling: Dynamic scaling scales the capacity of Auto Scaling group as traffic changes occur
    - Simple Scaling: increase/decrease capacity based on single scaling adjustments, cuando se supera un porcentaje de potencia usada por ejemplo cuando se usa mas del 60% de las instancias
    - Step Scaling: Increas/Decrease capacity based on a set of scaling adjustments, se ajusta que se va a hacer por ejemplo si baja del 20% o pasa del 70%, si se aumentan o reducen instancias
    - Target Tracking: Increase/Decrease capacity to ensure a metric remains at a consistent value, analiza el desempeño de las instancias y con el promedio saca decisiones si aumentar o reducir instancias
  - Predictive Scaling: Uses machine learning to predict traffic patterns and scale your auto scaling group proactively in anticipation of changes
- Schedule Scaling, te permite escalar en tiempos predefinidos
- CoolDown period is the time it takes to performing scale operation before te ASG can scale up/down again
- Instance Refresh performs rolling update of instances after launc template changes

ASG capacity
- Minimum Capacity
- Desired Capacity
- Minimum capacity

Sticky sessions
- Esto hace que el load balancer mantenga a un usuario conectado a una sola instancia

# AWS RDS
- La data tiene que estar almacenada en un sistema robusto escalable y reliable
- Es un Fully Managed service, escalable autoactualizable, tiene disaster recovery, esta guardado en EBS
- Soporta Aurora, MySQL, PostgreSQL, MariaDB, Oracle, SQL server, IBM DB2
122
- Cuando tu base de datos tiene muchas read operations, se puede crear un Read replica, En bases de datos (como MySQL, PostgreSQL, Amazon RDS, etc.), una Read Replica es una copia de solo lectura de tu base de datos principal (master).
Se mantiene sincronizada automáticamente con la base de datos principal.
Solo se pueden hacer consultas (SELECT), no escrituras (INSERT, UPDATE, DELETE)., sirven para Escalar lectura, tener redundancia /disponibilidad, tener backup y analisis

# AWS Aurora
- Tiene mejor performance scalability availability y durability precio y es en general mas facilmente manejada
- Usa MySQL y PostgreSQL
- La estructura normalmente existe una instancia primaria y hasta 15 replicas, para leer pero no escribir, tiene multi AZ deployment, data replication, primary y replica instances, tiene automatic Failover y fault-tolerant storage
- Cluster volume: una forma de distribuir y redundar el storage, es manejado automaticamente, y self-healing
- Un Aurora endpoint en AWS es una dirección de red (DNS) que permite conectarse a una base de datos Amazon Aurora, ya sea al clúster completo, a la instancia principal (writer) o a instancias de lectura (readers). Se puede usar para conectarse a la base de datos desde aplicaciones, balancear lecturas entre réplicas, o ejecutar escrituras en la instancia principal.

# RDS Proxy
- Normalmente si muchas aplicaciones se conectan con una sola base de datos puede haber problema, en especial esto pasa cuando las lambda functions leen la base de datos, el proxy funciona como un load balancer
- Cuando ves un problema de RDS hablando de cpu issues por un gran numero de conecciones puedes usar el RDS proxy, cuando es grande el numero de conecciones

# Dynamo DB
- Es NoSQL, se guarda en key-value stores, document stores, column family stores, y graph databases
- Son mas escalables, tienen high performance, flexible data model, dynamo db tambien es cost effectiveness
- Es fully managed, se integra bien con todo el sistema AWS, tiene stream integration
- DynamoDB es ACID compliant 
  - Atomicity: Si tienes que operar multiple informacion en una base de datos, se guarda como transaccion, o ambas son escritas bien o ninguna se hace
  - Consistency
  - Isolation: Los cambios en cada operacion no son visibles para otras operaciones
  - Durability: Cuando los datos son finalizados los datos son durables y se mantienen
- DinamoDB tiene tablas, items y attributes
- Todos los nombres tienen que ser UTF-8 encoding, tienen que ser case sensitive 3-255 caracteres a-z, A-Z, 0-9, _, -, .
- Partition key: es la clave del item dentro de la base de datos
- Partition key + sort key = composite key
- PartiQL, permite usar SQL sy- Partition key + sort key: - Partition key + sort key: - Partition key + sort key: - Partition key + sort key: - Partition key + sort key: i
- Existe un Provisioned Mode, cuando conoces la capacidad anteriormente
- On demand que va cambiando dependiendo que usas
- Dynamo DB scalability
  - read capacity units
    - Max 3000 RCUs
  - Write Capacity units
    - Max 1000 WCUs
- EL WCU se calcula con (numero de escrituras por segundo x item size en kb) / 1kb
- Throttling: ProvisionedThroughtputExceededException, ocurre cuando
  - Exedimos el RCU/WCU provisionado
  - Hay mucha lectura en una misma partition key
  - Incufficient partition key varianceo
  - Large items

# Global secondary indexes
- Una query puede verse asi (product_id = 999, user = sam@gmail.com)
- Si haces una query tipo (product_id = 999) |> filter(is5Stars?), esto sera ineficiente por que el atributo stars no esta indexeado
- Algo similar pasa si buscas todas las reviews hechas por sam@gmail.com
- que es un LSI, esto ayuda a buscar justo este tipo de informacion, por ejemplo el rating o el usuario, te permite tener un sort key diferente, tienen que ser creados al momento de crear la tabla
- Las tablas soportan hasta 5 LocalSecondaryIndexes
- GSI te permite definir una nueva primary key (Partition key + sort key), son agregadas despues de la creacion de la tabla, permiten una nueva partition key y sort key, pueden ser creadas o modificadas despues de la creacion de la tabla, se tiene que proveer RCUs y WCUs en su creacion
- If GSI writes are throttled the main table also gets throttled

# DynamoDB api
- Se suele usar un CRUD para interactuar con la base de datos
- Se puede hacer un GetItem (Partition Key, [Sort Key])
- Query: trae multiples datos
- Scan: Scans whole table, not efficient but in some cases useful
- PutItem
- UpdateItem
- DeleteItem

Estan las operaciones basicas
- CreateTable
- DeleteTable
- BatchWriteItem - Put/Delete 25 items at once
- BatchGetItem- Return up to 100 items from one or more tables

# DynamoDB Conditional Write
- Se pueden usar condiciones al escribir en un item
- Se suele usar cuando dos personas escriben en un mismo lugar al mismo tiempo
  Expresions supported
  - Attribute Exists
  - Attribute not exists
  - Attribute type
  - Begins with
  - Contains

# DynamoDB Optimistic Locking
- Se agrega un nuevo atributo llamado version, cuando haces cambios solo puedes modificar informacion con la version que lees, asi si dos personas modifican algo al mismo tiempo solo el primero tiene permiso de cambiarlo

# Dynamo DB transactions
- Supongamos que compras algo, hay dos tablas una de ordenes y otra de tabla, una transaccion hace que una operacion se ejecute con ambas tablas, asi si una falla no quede data dessincronizada en la otra base de datos Correcto ✅: Una transacción evita que se guarde un registro en la tabla de órdenes pero falle en la tabla de pagos (o viceversa). En caso de error, se hace un rollback y nada se guarda, evitando desincronización.

# DynamoDB TTL
- Elimina informacion cuando expira en una base de datos

- Projection expresion: Retrieves a subset of attributes