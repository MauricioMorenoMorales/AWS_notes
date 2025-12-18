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
- Si la RDS llega a sus limites de procesamiento de read requests podemos crear read replicas, cualquier pregunta en el examen acerca de mucho uso de cpu pro read requests, las read replicas son la respuesta, se pueden usar hasta 15 replicas, la data es sincronizada asincronamente para leer replicas, leer replicas en la misma region no cuesta dinero pero si si lo haces entre distintas regiones
- Sandby databases can be deployed in a different AZ changes will be synced synchronously

# AWS Aurora
- Tiene mejor performance scalability availability y durability precio y es en general mas facilmente manejada
- Usa MySQL y PostgreSQL
- La estructura normalmente existe una instancia primaria y hasta 15 replicas, para leer pero no escribir, tiene multi AZ deployment, data replication, primary y replica instances, tiene automatic Failover y fault-tolerant storage
- Cluster volume: una forma de distribuir y redundar el storage, es manejado automaticamente, y self-healing
- Un Aurora endpoint en AWS es una dirección de red (DNS) que permite conectarse a una base de datos Amazon Aurora, ya sea al clúster completo, a la instancia principal (writer) o a instancias de lectura (readers). Se puede usar para conectarse a la base de datos desde aplicaciones, balancear lecturas entre réplicas, o ejecutar escrituras en la instancia principal.
- Data is replicated between 3 AZs wth 6 opies
- las replicas solo puedn ser leidas
- Escanea automaticamente y repara errores


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
  se arregla 
    - Dsitribuyendo partition keys
    - Exponencial backoff when exceptions occur
    - Utilize DynamoDB Accelerator (DAX) if the throttling is due RCUs

- Se puede configurar para seleccionar la consistencia que quieres
  - Eventually consistent read
  - Strongly consistent read: mas caro

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
- Las transacciones ocupan 2x WCYs y RCUs que uno normal

# DynamoDB TTL
- Elimina informacion cuando expira en una base de datos
- Projection expresion: Retrieves a subset of attributes

# Dynamo DB streams
- Te permite guardar records de eventos que estan ocurriendo en la tabla, esto se puede asociar a distintos eventos, tipo lambda o kinesis firehouse and data analytics, puedes leer keys, new_image, old_image, new_and_old_image, para ver como era antes del cambio o despues del cambio
- tiene 24 hour retemption

# DynamoDB Dax
- Cuando una base de datos es read heavy, puedes usar DAX que es un cache, esto acelera ese tipo de procesos, esta disenhada especificamente para dynamoDB
  - Fully managed cache
  - Compatibility with DynamoDB API
  - Ideal for high reads workloads
  - Customizable Time-To-Live (TTL) settings
  - Scalability and High availability

# ElastiCache
- Mejora el preformance de la aplicacion para aumentar la velocidad
- Managed service
- Uses open source cache engines, with Redis y memcache

# MemoryDB for Redis
- Los casos de uso comunes para este servicio serian los siguientes
  - Ride sharing app: guarda data real estatus localizaciones, user profiles, session states, ride and delivery requests, prices
  - MemoryDB replica data entre distintas AZ, y es recuperable y una durabilidad mayor a solo redis
- Fully managed
- Redis compatibility
- Failover management
- Scalability
- Cost Effectivenes
- Se pueden particionar en shards
- Se pueden hacer snapshots de cada base de datos en cualquier punto
- Se diferencian en estas cosas de elasticache
  - MemoryDB tiene focus en availability y durability, elasticache solo en performance
  - Full durable automatically replicates data between AZ, Elasticache Optional durability
  - MemoryDB es sincrona y elasticache asincrona en cuanto a replicaciones
  - MemoryDB es mejor si quieres durabilidad rapida, y elasticache cuando quieres velocidad a toda costa
  - MemoryDB es mas cara que elasticache

# CloudFront y CDNs
- Los cdns son para acercar contenido geograficamente al cliente
- Cloudfront te ayuda a manejar el acercamiento de tus contenidos al cliente, los distribuye a edge locations
- Origin is the source location for content that will be cached by cloudfront, es el recurso que se distribuira
- Puedes crear una distribucion en clud front, es una unit/block en cloudFront
- Primero cloudfront recibe el request busca sus edges location como un cache, y si no la encuentra va al s3, funciona con una logica similar a un cache
- Se pueden configurar los s3 con cache invalidation para recibir las requests directamente
- El TTL determina cuanto tiempo se van a cachear los archivos
- Las distribuciones son single unit of configuration de cloudfront
- supongamos piden un carro rojo una vez, este carro rojo se mandara a cloud front pero despues se actualiza el s3 con un carro azul, si vuelves a hacer una paticion no te aparecera azul si no rojo, por que esta en cache para actualizar todo se tiene que hacer un cache invalidation

# Cache behavior
- Tells cloudfront which origin would like it to retrieve objects from
- Cloudfront cache: cuando un usuario pide algo primero a un edge location se genera un cache key que identifica un nuevo archivo dentro de el cache, hasta hacer hit al archivo, si no hace hit osea hace un miss se va a s3
- Las cache keys son para identificar recursos movidos por cloudfront
- El cache policy registra reglas a seguir por cloudfront, pones el resource si hay queries si hay hostname, defines aca el ttl
- Si el request tiene otros atributos como language, query parameters o cookies se tienen que agregar al origin policy

# Signed URLs
- Restringen el acceso a contenido, solo usuarios con un sign url valido tienen acceso
- Es normalmente usado en streaming services, o private documents, o confidential resources
- Funciona similar a las s3 signed urls
- Tambien existen las signed Cookies, normalmente se usan cuando vas a usar muchos archivos, mientras que la URL es mas para algunos pocos archivos uno por uno

# Clopudfront Geographic restriction
- Aqui puedes decidir que paises pueden ocupar este servicio
- Se pueden usar Whitelists o Blacklists, para definir quienes entran y quienes no entran

# Elastic Beanstalk
- Elastic beamstalk te ayuda a que te centres en tu app en vez de andar haciendo arquitectura
- En vez de que entres configures login load balancers databases y ec2 instances usas beanstalk
- Te ayuda tambien a hacer health checks
- Los developers se concentran mas en foco y productividad
- Resource y cost optimization
- No cuesta cargos adicionales, solo pagas por lo que usas 
- Tambien te dan environments, uno para development y otro para production con las mismas caracteristicas
- Existe el worker environment, que procesa varias tareas en el background que la app necesita
- Cuando haces un deployment, tienes varios tipos
  - Single instance deployments: solo ocupas un ec2 instance
  - High-Availability deployiment: usas distintas ec2 con un load balancer
- Le tienes que agregar un IAM role a beanstalk para que pueda manimular o crear servicios de AWS
- Cuando deployeas tu codigo este se guarda en buckets versionadas de S3
- Te da durability y reliability, version control, security y scalability
- Elastic beanstalk puede ser usada con cloud formation
- Se integra con CI/CD Pipelines

 # Deployment options
- All at once and rolling, actualiza todas las instancias a la vez, rolling va haciendolos poco a poco
- Rolling with Additional Batch: introduce mas instancias nuevas primero y va terminando y reiniciando las demas hasta que todas esten actualizadas, es mas cara por que ocupas mas istancias
- Immutable: Despliegas una nueva version de auto scaling group con la nueva version , cuando esten todas desplegadas los mergeas
- Traffic splitting: usas el load balancer para ir direccionando a una version vieja y nueva en  aws
- Blue / Green: se inicia un nuevo entorno beamstalk y se van distribuyendo las cargas entre ambos entornos, usa route 53 para direccionar al environment


# Lifecycles policies
- Se pueden agregar un numero maximo de versiones disponibles, borrar las mas viejas
- Se suelen borrar versiones dependiendo el tiempo que esten sin usar
- Delete Source bundles
- Delete protecton: proteger algunas versiones de ser borradas
- Se pueden borrar de beamstalk pero mantener en un s3

# EBextensions
- Se pueden configurar beamstalk con la consola, pero tambien se puede agregar un archivo llamado .ebextensions, por ejemplo .ebextensions/network-load-balancer.config

# Tipos
- Beamstalk soporta docker
All-At-Once: update es el mas rapido pero tiene mas impacto al usuario por que no se pueden usar los servidores

# Containers
- Un contenedor te permite guardar una aplicacion y los archivos necesarios librerias y dependencias que necesita la app
- Es como una version ligera de virtual machines
- Es un sistema escalable, y va dando availability si el servidor en el que tienes tu app es cerrada
- Container orchestrators are the brains of a containerized environtments
  - Deploys containers across all available servers
  - Load balances
  - Restarts failed containers
  - Moves containers when hosts fail
  - Provides container to container connectivity
  - Se suele usar Kubernetes, apache mesos y ECS

# Elastic Container Service
- Ayuda a orquestrar y manejar las aplicaciones, es un orquestador de contenedores
- Es un servicio manejado por AWS
- Corre sobre EC2 instances y fargate
- ECS es un software propietario solo disponible en aws
- Task Definition
  - Es una instruccion para decirle a ECS como quieres desplegar las imagenes, un template de como subir un container
- Launch Type: aqui se configura las caracteristicas de los EC2
- Launch type: Fargate, no tienes que proveer las instancias, ECS se encarga de crear el entorno
- Container Instance Role: cuando usas una instancia EC2, se le tiene que dar un rol al EC2 para que pueda crear y administrar recursos o mostrar logs, es un rol
- ECS Task Role: Este permite a un servicio ECS hablar con otros servicios
- ECS Load-Balancer: Puedes crear un load balancer para cada servicio
- ECS With EFS for persistent volume, aqui puedes crear un file system entre contenedores
- ECS Placement strategies
  - Binpack: ECS despliega las instancias buscando maximizar o llegar al 100% de la potencia de tu instancia para ahorrar
  - Spread: Distribuye equitativamente las tareas en distintas AZ o lugares
  - Random: Selecciona de manera aleatoria las EC2 instances
- ECS - CI/CD Pipeline: se puede integrar un CI/CD a tu aplicacion
- ECS Autoscaling, ECS tiene la posibilidad de auto escalar tus tareas
- No estas siendo cobrado por ECS solo por el computo
- Los puertos expuestos por tu app tienen que ser los mismos expuestos en el contenedor
- Cuando creas un servicio el numero de tasks que crees seran la cantidad de instancias que se crearan
- ECS has two roles
  - Container instance role - used for pulling images launching containers and sending logs & metrics
  - ECS Task Role - used for tasks that need to access other AWS services

# Updating ECS Task
- Minimum healthy percent, Maximum health percent: number of tasks that need to be running during an update, significa que tu numero de tareas no pueden pasar de cierto numero, por ejemplo siempre tiene que haber un servicio abierto para que no se corte el trafico

# Elastic container registry
- Simplifica el proceso de crear y deployear docker container services, para usar kubernetes o docker swarm
- tambien se puede usar con EKS
- Existe el Public ECR, para open source proyects, y el ECR las cuales son usadas para organizaciones en general
- ECR comprime imagenes, encripta imagenes, maneja versiones de imagenes, su lifecycle y maneja el control de acceso

# Elastic Kubernetes Service
- Kubernetes is an open source container orchestrator
- Kubernetes cluster has two types of nodes
  - Control plane nodes - managers of the cluster
  - Worker nodes - responsible for actually running the containerized work loads
- Managing control-plane/master nodes is difficult, the user is responsible both managing the nodes
- AWS Elastic Kubernetes service is a managed kubernetes service
  - EKS manages the control plane for you
  - Users are still responsible for managing worker node
  - Unless the decide to use Fargate (AWS will manage the nodes)
- Can be integrated with IAM, Elastic load balancing, ECR
- Existen dos tipos de launches
  - Fargate, aws maneja los pods
  - EKS with EC2 tu manejas los contenedores
- EKS LoadBalancer

ECR
  - Fully managed docker container registry service provided by aws
  - Support private & public repositories
  - Supports image scanning and lifecycle policies

ECS vs EKS
  - ECS is propietary to aws migrating for other resources is difficult
  - ECS is simplier
  - EKS es mas dificil, pero tiene un ecosistema gigante
  - ECS no cuesta dinero solo la infraestructura, EKS es mas caro

# Amazon SQS
- Se siele usar para evitar degraded performance y higher cost, cuando un servicio puede ser abrumado
- SQS da message decoupling, procesamiento asincrono, tiene scalable architecture
- Components
  - Queue: el principal componente, recibe mensajes con informacion
  - Producers: quienes  mandan el mensaje a la cola
  - Consumers: quienes la consumen
  - Message Attributes: Key value data
  - Visibility Timeout: cuanto tiempo se mantiene un mensaje visible en una cola
  - Lock message
- un producer puede ser un servicio tipo EC2, lambda, S3, los cuales tambien pueden ser lambdas o EC2
- Existen los standard queue y los fifo queue
- SQS standard queue: Best effort ordering, at least once delivery, maximum throughput
  - no vas a recibir respuestas en un orden correcto y puedes recibir una respuesta mas de una vez
  - Tiene maxima retencion de 14 dias
  - 257KB por mensajes
- SQS FIFO Queue
  - Strict order
  - 300 messages per second
  - 9000 messages
  - Aqui si recibes el orden correcto sin duplicados
  - Message grouping
  - limited throughput
  - Maximum retention period of 14 days

SQS Extended Client Library
  - Se usa para contenidos de mensajes largos, se guardan estos en un S3 bucket, y se maneja la referencia, se manda la referencia al objeto al consumidor
  - soporta hasta 2GB de contenido
  - Backwards compatibility
  - Cuesta mas
  - Easy to use

SQS with auto Scaling Group
  - se pueden trackear los mensajes recibidos y escalar el tamanho del grupo
  - Tambien estan los SQS Access Policy para establecer quien puede hablar con una cola

# SQS Settings
- Pone un tiempo, para que el consumidor pueda ir y ver si puede obtener informacion, durante este tiempo nadie puede revisarla
- When consumer processes a message the message will not be seen by other consumers during the visibility timeout, it should be long enough to account for how long it takes to process a message
- Delay Queue: no se puede ver el mensaje hasta que pase un tiempo
- Short polling: Los consumidores van a checar el SQS varias veces, esto es ineficiente, con long polling, cuando traes informacion mantienes la coneccion abierta y observas esperando a que traiga respuesta eso se le llama long Polling

- Que es un dead letter queue?

# SQS Dead Letter Queue
- Cuando la funcion que tiene que ejecutar el queue falla, se trata otra vez de ejecutar n numero de veces este retry con un threshold, si esto continua se manda un dead letter queue, en el que se detalla informacion para que pueda analizarse el error

# SNS
- Es como un gestor de correos, que se mandan a distintas personas
- Tenemos publishers o producers, los cuales publican info a SNS los cuales mandan la informacion a sus subscribers

SNS topics
  - Publicas a un topic y solo los consumidores que estan suscritos a esos topics reciben el mensaje

- Puede usarse varios publishers, budgets, S3, auto scalers, beanstalk, cloudwatch, security services, tambien se pueden usar varios servicios como subscribers, redshift kinesis data firehouse, s3

- Se puede usar un Fanout architecture, que se replica en diferentes endpoints, por ejemplo se puede usar en publicacion de videos se notifiquen a todos los subscriptores

- Puedes usar SNS Policies para definir quienes pueden hablarle a tus SNS services

# AWS Events Bridge
- Te ayuda a administrar eventos entre diferents targets, puede ser cualquier tipo de evento, subir buckets ec2 events lambda Sass o custom applications
- Se enrutan dependiendo las reglas las cosas a otros servicios
- Un event bus es un router que recibe eventos y los manda a ciertos targets
- Se pueden establecer timeouts

# AWS Step functions
-  Step functions ensures seamless and reliable order fullfillment
- cuando tienes muchos servicios interactuando puede haber problemas
- Estas funcionas paralleliza, manejan errores retries y escalations, y permiten ver el workflow
- Estas funciones por ejemplo pueden ser usadas durante el procesamiento de pago para verificar riesgos o fraudes
- Pueden checar que el inventory tenga el producto, genera labels en el shipping label, y verifican el shipping o completion
- Pueden ser usadas para verificar que las personas no suban contenido inapropiado
- Si hay error se puede mandar a otro servicio para ser verificado por otras personas, o puede ser publicado si no ahy error
- Cada step tiene que tener un task state
- Task states represents a unit of work being done by another aws service
- Step Function states
  - Pass - Passes its input without performing work
  - Choice: Adds conditional logic to state machine
  - Fail: Stops the execution of the state machine and marks it as failure
  - Succed: stops execution succesfully
  - Map: Run a set of workflow steap for each item in a set
  - Parallel: Run separate branches of execution

- Task token
  - Cuando tienes que hablar con un sistema tercero le puedes mandar un token, y cuando este terminado se toma ese token y se pasa a este step, el token dice continua con el workflow, por ejemplo al validar el pago con tarjeta de alguien

# Lambda
- Normalmente cuando creas aplicaciones necesitas sistemas operativos dependencias fixear bugs aplicar patches etc
- requiere de un trigger, y se ejecuta una funcion
- Es un servicio en el que no manejas ningun servidor, solo pagas on-demand, automaticamente escala
- Tambien se pueden desplegar con container images
- Puedes llamar una funcion desde el api gateway
- Con esto se suele crear arquitecturas de micro servicios
- Los eventos pueden tener un event object y un context object
- Las formas de aumentar la potencia de la lambda function es con mayor memoria pero esto hace que cueste mas dinero la mejora

# Synchronous and asynchronous
- Una llamada es sincrona cuando un usuario invoca una funcion y espera su respuesta, los errores suelen ser manejados por el cliente
- Synchronous invocation: api gateway, load balancer, s3 batch, lambda edge, amazon cognito, step functions
- Asynchronous invocations: son cuando no tienes que esperar a la respuesta, background processing jobs, o son servicios que no retornan respuestas
- SQS, event bridge, S3 events, Simple notification service


# Lambda layers
- Se usan para compartir dependencias por ejemplo un node modules compartido entre distintas lambda functions

# Lambda with ALB
- Se puede agregar application load balancer a las lambdas, se asocian a unas reglas que escuchan un listener, despues se va a un target group y estos target groups executan las lambda
- Multi header values: se puede transformar las queries o payload a un json con los query parameters y headers

# Lambda permissons
- Las lambda functions tienen que tener un execution role, que usa IAM roles y policies, ya que estas tienen que interactuar con S3 o cloudwatch

> Las lambda functions pueden usar environment variables y encriptarlas con kms

# Lambda versions
- Puedes versionar o hacer snapshots de cada lambda function, puedes tener distintas versiones una para qa o para produccion
- Lambda Aliases: se puede poner una funcion usando un aliases, pero esta tambien puede funcionar como load balancer, direccionando trafico a distintas funciones que comparten el mismo nombre

# Lambda Dead LEtter Queue
- Si falla una funcion se puede hacer retry unas cuantas veeces

# Lambda Destinations
- Puedes hacer o definir con este concepto que va a hacer la lambda function una vez completado
- Las destinaciones solo son aplicables para lambda functions asincronas, tiene success y failure handling

# Monitoring
- Podemos usar cloudwatch para ver invocations, duration, errors, success rate, throttles, concurrent executions, Asyn Delivery Failures, Dead letter errors, Iterator age, Provisioned Concurrency utilization
- Lambda Tracing x-ray: esto se activa con el active tracing setting
  - Esta lambda function necesita IAM permissons to send x-ray tracing

# Lambda Networking
- Lambda functions by default can access the internet but cannot access private subnets in a VPC
- You can run Lambda functions within a VPC which will create an ENI for them in the private subnet
- When run in a VPC lambda functions will not have access to internet, and you will need a NAT gateway or VPC endpoint

# Lambda Execution context
- Eecution environtment - Isolated runtime environment that manages the resources required to run your Lambda function, is created when lambda function is invoked
- Execution context remains available for some time in anticipation of your function getting invoked again
- It can reuse the context from previous invocation
- Since the execution context gets reused for subsequent invocations
- Great for initializing database connections as well as SDK and HTTP clients
- Un error comun que suele pasar es inicializar la coneccion de la base de datos dentro de la lambda function (la funcion principal que estas exportando), esto no es optimo se reinicia la coneccion siempre, es mejor inicializarla fuera de la funcion
- Puede llegar a 10gb en tamanho

# Lambda storage
- Code Storage
- Temporary Disk Storage /tmp: Se destruye cuando cambia el contexto
- AWS Lambda Layers
- S3
- Elastic File System (EFS)

- EFS supports up to 25000 connections per file system
- Lambda instances maintain EFS connections across invocations
- Reserved concurrency limits lambda connections
- EFS can handle 3000 burst connections and then 500 per minute
- One can monitor connections via the ClientConnection metric in cloudWatch
- EFS uses a bursting model: throughput scales with size, excessive read/write ops deplete burst credits throttling performance
- Burst credits accumulate and are used with read/write ops
- Provisioned concurrency functions are use burst credits even when idle
- One can monitor burst creditBalance metric to manage throughput
IOPS
  - IOPS measures read/write operations per second
  - General purpose mode caps IOPS for lower latency, suitable for most apps
  - Monitor percentIOLimits for IOPS usage
  - Reaching 100% on PercentIOLimit can cause function timeouts due to delays

# Limits & concurrency
- Existen cold starts que son los processos que pasan cuando se llama una funcion que no ha sido usado durante un buen tiempo
- Estos son limites que alica aws para mejorar el rendimiento, solo un numero de funciones pueden correr concurrentemente
- los soft limits son los siguientes: configurables
  - Concurrent executions: 1000
  - Function and layer storage: 75GB
  - Elastic network interfaces per VPC: 250

- Si una funcion alcanza las 1000 concurrencias, las demas ya no podran pedir nuevas instancias, dara un error throttleError 429

- Hard Limit: Inmutables
  - Memory Allocation: 128MB to 10240 MB with 1 increment
  - Function timeout: 15 minutes
  - Deployment package size: 50MB for .zip, 250 MB for zip files inS3
  - Environmental Variables: 4kb
  - Layer limit: Up to 5 layers at the time, max 250MB
  - Function Layers: Maximum size of a function 250MB, single layer 50MB
  - Ephemeral storage: 512 MB to 10GB
  - File descriptor limit
  - Execution processes or threads

# Lambda and cloudfront
- Se puede usar cloudfront para las lambda functions
- Cuando se ejecutan las funciones?
  - cloudfront: Cuando cloudfront recibe un request de un viewer, y antes de que cloudfront mande un request al origin
  - Lambda@Edge: los mismos que cludfront, ademas de cuando cloudfront recive una respuesta del origen, antes de que cloudfront retorne una respuesta al viewer
- Cuando se usan las cloudfront functions?
  - Son usadas para cache key normalization
  - Header manipulation
  - URL redirects or regrites
  - Request authorization
- Cuando se usa lamhda edge
  - Long running functions
  - Configurable CPU and memory functions
  - Dependencies on third party libraries
  - Network dependent functions
  - File System or HTTP request access function

# TIPS
- If you increase memory for the lambda function it will also increase cpu power
- Provisioned concurrency allocates instances upfront to mitigate cold starts
- CLoudfront functions run when cloudfront receives a request or sends a response back to the user
- Lambda@edge triggers on cloudfront request response origin request and origin response

# API gateway
- EL gateway funciona como un guardia de seguridad en la entrada de una plaza, esto hace que las tiendas internas no se preocupen por seguridad por que la entrada principal esta protegida
- Is fully managed, has version management
- Supports restful API and websokets, supports throttling and caching, api gatewas integrates with IAm to make identification and authorization
- Endpoint types
  - Edge optimized
    - Usa cloudfront para acercar a los clientes
  - Regional
    - Es especifica para una region, ideal para gente en una misma region
  - Private for VPCS: se usa para servicios internos
- Se puede crear una REST API, HTTP API o Websocket
  - El REST API tiene mas features pero es mas cara
    - Suporta api keys
    - Request validation
    - Request and response transformations
    - Suports all endpoint types
    - Full suite of monitoring & logging
  - HTTP API
    - Optimizado para mejor performance
    - Streamlined for core functionality
    - More cost efective
    - Built in cors support
    - Automatic deployment

# API stages
- Aqui puedes crear stages, tipo qua staging y prod, con distintos urls para poder estar probando tus entornos
- Tambien existen stage variables que son variables de entorno que cambian dependiendo el entorno que estemos usando
- se suelen usar al crear la api gateway en el arn por ejemplo
arn:324234/function:${environment variable}

# Canary Deployment
- Se puede tener una version en produccion y un 10% a un canary state para testear la siguiente version

# Integration types & Mapping templates
- Como la data es enviada entre el usuario api gateway y server
  - EL usuario manda un request con metod headers y body
  - Estadata la recibe el gateway y puede enviar la data al target, pero tambien puede extraer data y mandar solo lo importante, extraer headers y body
- Integration type mock, aqui el api gateway no envia la info de internet a lambda
- AWS_PROXY: cuando el usuario manda el request, el api gateway extrae data necesaria y se manda al lambda, solo funciona como proxy
- HTTP_PROXY: igual que el anterior pero en vez de lambda usa un server
- Integration type AWS: Aqui el api gateway extrae la data y mapea completamente la info que se manda a los lambda
- Integration type HTTP: similar al type aws pero con un server

# CORS
- Por default el web browser no puede enviar requests a un server de un dominio diferente, cross origin resource sharing nos ayuda a arreglar este problema, el API gateway te ayuda a cambiar este comportamiento por defecto

# Open API
- Es una especificacion que te ayuda a documentar como una api debe de ser configurada

# Caching API gateway
- Se puede habilitar para algunos environments, esto es usado especialmente para el development environment
- Cache invalidation: El usuario para invalidar el cache tiene que tener IAM permissons
- Esto suele ayudar a gastar menos en los entornos de desarrollo

# Authorization and authentication
- Aqui se suele verificar si el usuario tiene permiso para acceder a algun servicio, se puede llamar a un lambda authorizer, que se contacta a un oauth provider, se puede asignar una policy temporal en cache para que continue trayendo data
- Tambien el usuario se puede contactar con cognito y traer info la que ya despues el gateway se encargara de verificar

# API Keys & usage plans
- Un api key permite el acceso a una API, tiene que ser incluida en el header de los requests
- Existen usages plans, especifican quienes pueden acceder a deployed apis, y que tantos usuarios pueden usar esa api, por ejemplo si se pueden hacer 100 requests por segundo, definir que tanto
- La key se asocia a un usage plan
- Se pueden usar distintos usage planes uno para usuarios normales o premium etc

> Tambien puedes usar websokets con la api gateway

# SAM Basics - Severless application mode
- Simplifies serverless deployment
- Extension of AWS Cloudformation
- Local Development and Testing
- Integrated With AWS Services
- CI/CD Integration
- Con el comando sam sync --stack-name (stack) -- watch puedes sincronizar cambios locales con los subidos en remoto 

SAM COmponents
  - Sam template: un archivo de configuracion con los servicios usados
  - SAM CLI
  - SAM Repository: Ayuda a reusar componentes

SAM Template
  - Aqui tienes que proveer toda la info de los servicios que usaras

# SAM policy templates
- Las sam policies te ayudan a darle permisos a lambda functions o servicios integrados adentro, puedes encontrar policies pre configuradas

# CLI SAM commands
- SAM init
- SAM build
- SAM deploy

# KMS
- Simetric y assimetric encription
  - EN la simetrica una llave descifra y encripta
  - La asimetrica una llave encripta y otra deencripta
- KMS te ayuda a crear manejar y guardar las keys, usan policies para determinar quienes las pueden usar
- Existen dos tipos de llaves, las client managed keys y las AWS managed keys, en las AWS managed keys no hay mucha personalizacion
- Tenemos varias categorias en key management service
  - Control: Customer control, create delete enable disable schedule deletion auto-rotat, aws controls key rotation and policy management customers viws metadata only
  - Key policies: Customers manage access, define keey policy and IAM policies, AWS manages key policy customers cannot view or change
  - Visibility: Customers view all usage and management events in CloudTrail, Customers view usage events only
  - Customers enable/disable automatic annual rotation or rotate manually, AWS autorotates annually customers cannot change schedule
  - Keys used with any AWS KMS-integrated service customers decide usage
  - Keys used by specific AWS services only: each service manages keys
  - Cost Costs for creation and usage of customer managed keys in AWS KMS, no direct cost for creation and usage indirect costs for AWS services using these keys
  - kms can only encrypt 4kb, you need to use generatedatakey api for that
- KMS has adjustable resource quotas; breaching them triggers a LimitExceeded Exception
- Request quotas limit API operations per second; surpassing them leads to to a throttling Exception
- Handle KMS throttling effectively with exponential Backoff
- Utilize data key caching for envelope encryption
- Request an AWS limit increase if necessary
- Define Key Poicies for all key operations: Create, delete, encrypt and decrypt

Los comandos usados para encriptar y desencriptar suelen ser estos
```bash
aws kms encrypt --key-id alias/demo-key --plaintext \
  fileb://password.txt --output text --query CiphertextBlob > password.txt.encrypted

aws kms decrypt --ciphertext-blob fileb://<(cat password.txt.encrypted | base64 --decode) --output text --query Plaintext | base64 --decode > password.txt.decrypted
```

# Systems manager parameter store
- Secure storage of rconfiguration data and secrets, stores also database strings passwords, plain text and encrypted data
- Es el parameter store que usabamos en fmi xd
- Existe una jerarquia, en la que se clasifican los parametros en distintas secciones, tipo auth , database, todos estan bajo el directorio /org
- Se pueden agregar expirations, que eliminan el parametro en algun momento
- Existen expiration notifications
- Existen NoChangeNotification, notification for unchanged parameter

## Secrets managere
- Es como un parameter store pero te permite guardar informacion sensible
- Existe rotation invoking

# ACM Amazon certificates manager
- Un certificado te prueba que eres dueño de un dominio, estos te sirven para autenticacion
- Se usa en Elastic load balancer, en amazon cloudfront y en elastic load balancer, no en s3 lambda o ec2

# AWS Cognito
- Este servicio te ayuda a manejar las sesiones, login entre otros
- Maneja credentials sessions y passwords
- Cognito es para tu propia aplicacion no es como IAM
- Te da Password Storage
- Integracion con identity providers
- Te ayuda a acelerar el proceso de crear una aplicacion
- Pagas por uso, los primeros 15.000 usuarios son gratuitos
- Cognito user pools: incorporates authentication into an app, manages user sign-up and sign-in functions
- Cognito Identity pools Enables app users to directly access AWS, provides AWS credentials directly

# Web application Firewal (WASF)
- WAF Monitors all HTTP requests made by client (legitimate users or hackers) that are forwarded to web applications
- Los WebACL son reglas para validar al usuario
- Proteccion contra ataques web comunes
- API security
- Protection para serverless applications
- Application layer firewal
- Integration with other AWS services
- Protege de layer 7 web exploits
- Protect threats like sql inyection y XSS

# Cloudwatch
- Monitorea otros servicios como EC2 Lambda, DynamoDB, S3
- Se pueden setear alarmas, para mandar mensajes, por ejemplo si se llega al 70% de la potencia de un servicio
- Se puede usar Metric insights
- Desde cloudwatch se puede revisar la capacidad de los EC2 y activar el autoscaling
- Existen metrics namespaces: las cuales se aislan entre aplicaciones la informacion
- Cada servicio esa dentro de su namespace
- Dimensions: te da mas informacion sobre los servicios usados
- Existen resoluciones
  - Standard resolution: With data at a granularity of one minute
  - High Resolution: With data at a granularity of one second
- Se pueden hacer log groups, por ejemplo para 2 apps distintas se pueden agrupar en un grupo y todos los logs se ponen en una misma consola, por ejemplo se puede usar para un grupo de aplicaciones relacionadas a un proceso
- Insights allows querying logs to derive more complex metrics and insights
- Los namespaces contienen cloudwatch metrics que mantienen la data isolada para prevenir agrupaciones innecesarias
- Cloudwatch logs agent: una version antigua de agents, puede solo mandar logs pero no metricas
- Cloudwatch unified agent: una nueva version del agente, puede mandar logs y metricas

# Cloudwatch alarms
- Se pueden setear alarmas para ciertos eventos, pueden lanzar notificaciones como administrador, llamar lambda functions, o publicar en SNS
- Las composite alarm mandan una alarma si se cumplen varias condiciones en vez de una

# AWS Cloudtrail
- Trackea y registra todas las interacciones entre las APIs, quienes ejecutan cosas que hacen y cuando lo hacen
- Trackea toda la actividad del usuario dentro de una cuenta de AWS
- Cada momento que un usuario hace una accion dentro de aws, un evento es logeado en cloudTrail
- Cloudtrail puede hacerle trigger a cloudwatch
- Existe cloudTrail Insights
- The events are stored for 90 days, but can be saved on s3 for more time

# AWS X-Ray
- Ayuda a los desarrolladores a analizar y debuguear distributed y microservices architectures
- Se tiene que importar X-Ray sdk para habilitar
- Trace collector, receives traces from application and forwards it to X-Ray
  - AWS Distro for open telemetry (ADOT) collector
  - Amazon CloudWatch Agent
  - X-Ray daemon
- X-Ray daemon/agent is already enabled on Lambda and other AWS Services
- Segments detail a resource work including request and response data tasks performed issues and timing information
- Subsegments provide more granular details about downstream calls your application makes to fulfill the original requests
- A trace is a set of segments representing the path of a single request through your application including its timing, disposition, and other data
- Anotations are key-value pairs used to index traces to be used with filters
- Metadata is key-value pairs not indexed and thus can't be used for filtering/searching
- Elastic beanstalk includes the xray daemon, lo puedes habilitar en .ebextensions/xray-daemon.config, tienes que configurar los IAM necesarios

# Kinesis
- Te ayuda a colecccionar data, procesarla y analizar,a por ejemplo en videos o data streams
  - Log processing, analizar los logs o hacer batches
  - Real-time metrics
  - Complex stream processing like directed acyclic graphs
  - IoT Telemetry data
- Existen estas versiones
  - Amazon kinesis video streams
  - Amazon Kinesis Data Streams
  - Amazon Kinesis Data Firehose

# Kinesis data streams
- Es como un pipe de data, un producer manda recursos a el data stream, y este lo manda a los consumers
- Kinesis Capacity modes
  - On demand: autoescala automaticamente, auto maneja shards para el throughput necesario
  - Provisioned: se establece el numero de shards
- Partition keys, es un tipo de id para definir a que shard se ira
- Una hot partition es un shard que sobrepasa cierto flujo pesado, esto genera un ProvisionedThroughputExcedded
- Puedes dividir el shard en dos shards, puedes mergear cold shards para ahorrr en costos
- Hash of the partition key determines which shard a record will go into

- Consumers
  - Cassic Fan-out consumer, cada shard comparte 2MB/s entre todos los consumers
  - Kinesis Client Library, Handles consumer failures, add checkpoints processed records, handles resharding
  - Puede correr en elastic beanstalk, ec2, on premise servers
  Solo podemos tener un Kinesis Client Library (KLC) por shard asi que el numero de instancias sera el mismo que el de shards

# Kinesis Data Firehose
- Delivers real-time streaming data to destinations such as S3 Redshift and OpenSearch
- Soporta data transformations con Lambda
- Near realtime
- Failed data can be send to S3 To analisis
- Kinesis data stream puede ser usado como data stream
- Ingest data in realtime
- Kinesis data streams
  - Scaling is handled by user, data is stored for 1-365 days
  - Soporta replay
- Kinesis Firehose
  - Store streaming data into S3, Redshift, etc
  - Near real time
  - Fully managed
  - No data storage
  - No replay capability

# Kinesis Data Analytics
- Te permite analizar data usando SQL
- Se usa para time-series analytics, real time dashboards, y real-time metrics
- sus sources solo pueden ser kinesis data streams y kinesis firehose, y sus sinks tambien (output)

# SNS vs SQS vs Kinesis
- SQS te ayuda a hacer decoupled architecture
  - Great for sending messages between services
- SNS manda data a varios suscribers
  - Data is not persisted
  - Data is segregated out by topic
- Kinesis
  - Real time data ingestion and procesing
  - Usado en Big data Analytics y ETL

# AWS Athena
- Analiza data guardada en S3 buckets usando SQL
- Serverles, pags por query, tiene built-in functions matematicas o utiles, suporta varios formatos de data, integracion con otros servicios de AWS

# Open search
- Es un fork de elastic search, te ayuda a ingest data, secure data, search data, agregate, view, and analize data
  - Log analytics
  - Application search
  - Enterprise search
- es un fully managed service, for easy depolyment opeartion and scaling of open search clusters, existen dos tipos de clusters
  - Managed clusters
  - Serverless clusters
- Usos
  - With dynamoDB we can only perform efficient queries on the primary key or attributes used un GSI/LSI
  - Rleational databases can only perform efficient queries on columns that have indexes
  - With openSearch we can efficiently query data on any field/attribute
  - This makes OpenSearch great for implementing search functionality in apps

# CodeCommit - VCS and git
- Es una alternativa a gitub y gitlab, pero tiene varios beneficios extra
- Distributed version control, para qu varias personas trabajen a la vez
- Branching and merging
- Staging Area, para revisar el codigo antes de mergearlo
- Non-linear development
- Tracking history

- Git workflog
  - Working directory
    > git add
  - Staging Area
    > git commit
  - Local Repo
    > git push
  - Remote Repo

- Es git compatible
- no size limit
- Tiene integracion nativa con IAM, para decidir quienes tienen acceso
- Es fully managed service

# CodeBuild
- Esta parte del proceso te permite lintear el codigo, formatearlo, correr unit e integration tests, build y package the code, upload artifacts
- Continuous delivery es cuando hay continuous integration (se hace buld y test), pero se deployea a stating y produccion manualmente, si se deployea a estas partes automaticamente es continuous deployment
- Codebuild te permite traer data de distintos lugares, s3 codecomit github gitlab etc
- Se suelen usar Buildspec.yaml para manejar este proceso
- En el valor install se especifican las apps que usamos tipo python, nodejs, y commands, alli sueles poner los comandos que vas a ejecutar
- pre_build, se ejecutan o instalan comandos
- Build, pasas los comandos que usaras al construir la app
- Se suele crear un artifact despues del build, por que se evita que llegue a produccion todos los archivos innecesarios tipo los .config .gitignore etc

# Code Pipeline
- Este servicio te permite llevar un proceso para desplegar un codigo, junta varios servicios de tal modo que facilite el uso de el pipeline
- Tambien permite un manual review del codigo, y despues se hace el code deploy
- Tiene integraciones con distintos servicios aws

# Code deploy
- Es un fully managed service que te permite desplegar distintos tipos de codigo, ECS, EC2, Lambda
- Automated deployments
- Centralized control
- Rollbacks
- Health tracking
- Rolling and blue green updates

- Tienes que setear un deployment group antes de usarlo, es donde se va a desplegar la app
- Luego se crea un deployment
- Tienes que especificar tus deployment settings
- Finalmente haces el deploy de la app

- En el archiov appspec.yaml especificas los archivos, comandos para parar el servidor, comandos para ejecutar despues de la instalacion, como correrla, los permisos usados

- Los code deploy agent necesitan permisos para acceder otros servicios, recibir policies, se tienen que crear primero para poder empezar a usar CodeDeploy

Existen distintos tipos de deployment types

- EC2/ On-Premise, AllAt Once, aqui los usuarios no pueden usar la app por un rato

EC2/ On-Premise, Half at a time se actualiza la mitad y luego la otra

EC2/On-Premise - OneAtATime

- Blue/Green Deployment Strategy: Se manda la gente al grupo azul pero tambien aal grupo verde el cual va a ser usado para testing

- Deployment Types - Lambda
- Tambien hay deployments lineares
- Esta el Lambda canary, se crea un lambda v2 y se manda el 10% del trafico alli, si ve que todo bien pasa el 100% del trafico a la v2

- ECS, tambien puede hacer algo similar a linear, va pasando el 10% del trafico poco a poco hasta llegar al 100% a la nueva version

- Tambien esta el all at once

# Code Star
- Da herramientas que facilitan el desarrollo y despliegue de apps a aws, te da templates para web applications web servers, cosas manuales que se usan cuando haces tu aplicacion
- Se integra con todos los otros servicios CI/CD de aws, tiene un team collaboration y issue tracking dashboard, se basa en role-based access controls, da pre configured Environments

- Los templates tienen los Programming languages, CI/CD pipelines, y compute platforms

- Puedes tener roles, developer, tester, viewer

# Code Artifact
- Te permite almacenar packages libraries repositories dependencies privadas o publicas,
- Funciona como intermediario, cuando requieres un package lo busca en internet y lo cachea, para tenerlo cerca del developer


# Code Guru
- Es un servicio con Machine Learning, te da ayuda dependiendo de lo que ve en el codigo, te da recomendaciones para mejorar la calidad del codigo, te permite mejorar el performance de tu aplicacion, hace reviews de tu codigo

# Cloud 9
- Es un IDE que te ayuda a escribir codigo, se escribe todo en el web browser
- Real-time collaboration
- Seamless integration with AWS
- Full UNIX terminal
- Corre detro de una EC2 Instance

# Code Whisperer
- Te ayuda a mejorar tu codigo dando comentarios a tu codigo, la diferencia con Code Guru es que code guru una vez subes el codigo a tu repositorio lo analiza, code whisperer corre en tu IDE mientras escribes el codigo

# Amplify
- Te provee lo que necesitas como frontend para subir productos frontend
- Puedes construir SSR web Apps, Single page web applications, native mobile apps, y cross app aplications
- Soporta desde javascript angular vue, hasta react native flutter java etc
- Facil configuracion, primero inicializas el proyecto, despues agregas backend services, authentication API storage etc, conectas el frontend, y despliegas la aplicacion

# Exam tips
en las policies de code commit puedes tener preguntas sobre los permisos, por ejemplo un developer puede hacer branches o algunas cosas pero no merges, el admin es el que crea o elimina repositorios

# APPConfig
- Cuando tienes que cambiar una pequeña configuracion en tu app no tienes que reiniciar todo el servidor, puedes usar environment variables, pero esto puede causar problemas si tienes distintas aplicaciones leyendolas
- Aqui se usa AppConfig, todas las aplicaciones tran su informacion de app config y cuando se hacen cambios a app config estas se actualizan
- Hace live updates sin cambios de codigo
- se suele usar para feature flags, Allow/deny lists, application tuning y centralized configuration storage

# MSK Kafka
- Kafka te ayuda a stremear data, se suele usar tambien amazon kinesis
- El servicio de aws agrega Zookeper que te permite manejar los clusters de kafka, aws te permite administrar todo lo de los servicios, automatic recovery, multy AZ deployment, 

# AWS Systems manager
- Te permite administrar tus sistemas modificar configuraciones, ver performance, cambiar calendarios inventario
- Primero tienes que instalar el SSM Agent, se puede usar en la consola CLI o SDK
- te da control centralizado, resource grouping, automations,  patch management, Operational insights, ayuda a el configuration management, administrar secret and configuration management, remote management, compliance enforcement, e hybrid capabilities
- Tiene un application manager y parameter store
- Tiene un change manager, te permite ver estructuradamente planes para realizar cambios a todas las apps
- Se pueden hacer Atomations
- Node Management, te permite manejar compliance inventory session manager, run commands, state manager, patch manager, distribuitors
- Incident Manager: Te permite detectar problemas notificar a los ingenieros via email o SMS y planear una respuesta rapida a este problema
