# The design for x Portion
- Esta certificacion busca que abarces 4 dominios
  - Seguridad
  - Reliability
  - Performance
  - Cost Optimization

- The well architected framework, tiene 6 pilares importantes
  - Seguridad: infraestructura, cosas que eres responsable y aws
  - Reliability: Fault tolerance resiliency
  - Performance efficiency: Scaling properly
  - Cost Optimization: The right service for the right job
  - Operational Excelence: Estos 2 no estan en el examen
  - Sustainability

- Buscaremos como aumetar el performnce seguridad o escalability en
  - Network services
  - Storage services
  - Compute services
  - Database services
  - Application Integration Services
  - Data x Services
  - Migration/Transfer services
  - Security services
  - Management services

# Design for security Agenda
- General design principles for the citadel of security
- Understanding the four foundtaions of cybersecurity
- Shared responsibility model for securiity
- Turning up security for (nine services)

Categories for security in design
Cualquier accion tiene que ir enfocada a una de estas categorias
  - IAM
  - Detection
  - Protection
  - Response

# security Design - Fundamental principles
- Tienes que tener ciertas ideas y conceptos mientras creas tus servicios
  - Que aspectos tiene la seguridad
  - Que aspectos aumentan la seguridad
  - Que aspectos reducen la seguridad
  - Cual es el objetivo final de nuestra seguridad
Aqui entran en accion los design principles

SAPTRAP: Los principios de seguridad suelen ser los siguientes

Strong identity management: Tener un manejo estricto de grupos roles y acceso y que cosas tienen acceso a que en que condiciones
  - Roles groups entitys IAM users
   Bucket Access Control Lists

Apply security at all layers of the infraestructure and app
  - Firewall, network defense, private firewal, host firewall

Prepare for security events, asegurate de saber que hacer en eventos de seguridad, muchas veces la gente cuando ve un ataque apaga la maquina pero pierdes el trackeo de las personas
  - Tiene que haber un plan de respuesta ante estos eventos

Trackea todo lo que sea relevante, consigue logs e informacion
  - Manten logs informacion estados configuraciones, todo esto es relevante
  - S3 Logs

Reduce contacto humano directo
  - Manten personas lejos de tus procesos, que no entren a tus maquinas, que ciertas personas sin conocimientos toquen hardware o procesos sensibles

Automatiza best practices
  - Si sabes que se tiene que hacer patch o security scans cada cierto tiempo este proceso se tiene que automatizar

Protect daa in all states, particularly important data
  - Encrypt data in all possible points
  - code repos files internal information
  - S3 Bucket/Object encrption

# Seven Areas of Cloud security
- Foundations
  - Laying the foundations of security in all the prework necessary to define, who, what, when, where and how
  - This area speaks to objectives for, ssecurity, updating, identifying threads and meta-information like acount management
- Identity and Access Management
  - What services are we using to prevent authorized access
  - This area governs identity and permission management
- Detection
  - Here we use logs and metrics
  - What services have actions to detect problems
    - unexpected configuration changes
    - unexpected actions
- Infraestructure protection
  What is protecting your infraestructure, what protects the subnets or the networks
    - Security at all network layers
    - Network inspection
    - Compute vulnerability assessments
- Data protection
  - Protect Data at rest, data in transit data classification
  - Encryption, key management, data lifecycle
- Application security
  - Evaluate software development pipelines
  - Software deployment pipelines
  - Securing end to end supply chain
  - Application penetration testing
  - Code reviews
  - Clean image and software sourcing
- Incident Response
  - Security education
  - Security preparation
  - Security simulation
  - Security improvement
  - Setting security response objectives
  - Running security scenarios
  - Identifying tools and access needed

# Shared responsibility model
- AWS se va a encargar del hardware, y software, computacion storage database y networking
- Nosotros somos responsables del sistema operativo network firewall configuration, client side data, encription, authentication,network traffic protection, platform application identity / access management y finalmente de la data del cliente

esto cambia dependiendo los servicios, lo anterior es aplicable a infraestructure services pero tambien esta
- Platform services: ademas se encarga del sistema operativo, firewall y network configuration y platform y application  management
- Managed services, esto ademas de los anteriores se encargan del network traffic protection y del server side encryption

- Lo mejor es usar managed services lo mas posible

# Designing for security
- Primero se pregunta que data se busca asegurar, te responden s3 o RDS
- Te pueden preguntar que hagas patch a un lenguaje de programacion
- A esto puedes responder, si un servicio soporta un requerimiento, o si no lo soporta pero podemos hacer...
- Como arquitecto como vas desde un request a una response
  - What area of security is this request targeting (punto anterior)

- What Task Statement is the requeriment?
  - En el examen veremos los siguientes puntos
  - Design Secure Access to AWS Resources
  - Design Secure Workloads and Applications
  - Determina Appropriate data security controls

Debemos de buscar la mejor solucion de seguridad, la mejor solucion se determina por cual es la mas barata

- Cosas que te sueles preguntr en el design, es si vas a tener diferentes zonas o diferentes segmentos en las zonas, deberiamos permitir a ciertas personas acceder a ciertas partes del edificio, como se protege cada parte del edificio, necesitamos zonas  redundantes, se necesita algun record de que hace cada persona?

- Una region es como un campus
- Una VPC te ayuda a dividir tu region, este es el edificio del campus con su propia entrada las cuales son el gateway
- Una availability zone es como un piso del edificio, aqui puede haber redundancia regularmente
- La seguridad del edificio es manejada en el route table, es como el policia que trabaja en el gateway. esta puede privar el acceso a ciertas zonas del edificio
- PAra entrar a los pisos prohibidos o internos tienes que ir primero a un piso permitido y usar una NAT Gateway
- Cada piso tiene un guardia de seguridad secundario, Network Access Control List (NACL)
- Existen egress gateways para el VPC
- Las oficinas tambien pueden tener sus propia seguridades, los security groups, en este caso las instancias
- Que pasa si necesitas direcciones o quienes son los recepcionistas, los DNS y DNS Resolvers, de route 53 o route tables
- Existen los VPC endpoints que te dan salida oculta a los servicios externos
- Que si necesitas enviar gente a ambos archivos, usar un recepcionista externo fuera de estos edificios, esto seria el load balancer

# Turning up security network services
- Si necesitas que distintas VPCs se comuniquen entre ellas de manera privada, usa VPC peering
- Los NAcl no se adieren a el least privilege principle
- Se usan los routing tables para manejar la comunicacion entre los servicios internos de las vpcs
- Puedes usar los IP addresses para permitir que tus developers se conecten a los entornos de desarrollo
- El NAT gateway sirve para que los servicios accedan a internet pero internet no accede a ellos, tienes que ponerlas en un public subnet, y las privates subnets se concatcatn con esta public subnet
- Si todos los elementos dentro de un vpc requieren solo traer informacion peroe no mandar puedes hacer un Egress-Only Internet Gateway en vez de un NAT gateway
- Las DNS se pueden usar internamente
- El elastic network adapter puede funcionar para tareas de high throughput y low latency como videojuegos etc
- El elastic fabric Adapter (EFA) permite comunicacion interna de muchos servicios internos a altas velocidades con high throughput

- NACLs significa Network Access control list

- Que es un egress only gateway
- Que es un Elastic network adapter
- Que es un Elastic Fabric Adapter
- Que es un efimeral port

In EC2
  in public subnet
    Multiplayer backend in a VPC
    needs outbound trafic but restrict all unsolicited inbound

# Designing for Rliability

# Tips
- Se suelen usar los Elastic network adapters para videojuegos, y los Elastic Fabric Adapter para aplicaciones que requieren niveles mas altos incluso en throughput

- En algunas ocasiones puedes usar el security group para dos servicios y estos ya deniegan el outbound traffic, y si pertenecen al mismo security group ya se comunican entre si

- Se puede usar AWS Certificate manager para enviar informacion a los clientes usando SSL/TLS y ya despues con el load balancer desencriptar la data

# Notes
- Normalmente las VPC Interface endpoint se suelen usar para comunicarse seguramente con S3 o Vault, storage en general

- S3 encripta la info por default, para evitar eso tienes que mover

- S3 tiene 4 layers de access control Public access Firewall ->  IAM -> bucket policies -> Access control Lists -> Block public access

- Es importante habilitar logging si quieres ver la info de S3

- Para data protegida tipo farmaceuticas tienes que usar COmpliance mode para que no se borre la data y governance mode para proteger esta data pero permitir excepciones

- Tambien puedes usar object lock para prevenir que se borre data

- Si s3 va a ser accesido por S3 tienes que hacer un VPC endpoint, agregar necessary routes al VPC route table to direct S3 traffic to the endpoint

# AWS backup
- Se puede agregar Legal Hold a backups para evitar que se borren por procesos legales
- Tambien se puede usar Vault Lock para evitar que se borren backups por n cantidad de tiempo
- En S3 es object lock y en AWS backup es vault lock

# AWS Recovery
- Con el protocolo TCP 1500 puedes mandar actualizaciones de tu estado por si se necesita un recovery futuro
- EL proceso de regresar al sistema original tras un recovery se le llama failback

# Tips
- Se suelen usar los Elastic network adapters para videojuegos, y los Elastic Fabric Adapter para aplicaciones que requieren niveles mas altos incluso en throughput

- En algunas ocasiones puedes usar el security group para dos servicios y estos ya deniegan el outbound traffic, y si pertenecen al mismo security group ya se comunican entre si

- Se puede usar AWS Certificate manager para enviar informacion a los clientes usando SSL/TLS y ya despues con el load balancer desencriptar la data

- Siempre haz doble cuando veas encripcion, siempre debe de haber encripción para seguridad

Que es un overlapping CIDR block?: Es un CLassless inter domain router, define el numero de VPNS 10.0.0.0/16 que estarn disponibles dentro de tu subred

ACL o access controll lists controlan subnets no endpoints

- Para encriptar contenido en cloudfront lo mejor es usar CMK customer managed keys

- Los instances volumes o EBS son efimeros la data puede perderse si el EC2 se cierra, por eso hay que usar S3
- Los Elastic file system permiten a toda una region acceder a la misma info, existe una version cold para esto

- Puedes usar los presigned urls para acceso temporal a tus apps, y usar encripcion para evitar robos

- Se puede encriptar la data entre el load-balancer y el cliente para aumentar seguridad y ya el load balancer desencripta la data en la subnet de manera segura y el sistema lo maneja allí

- Se puede usar un NAT gateway apuntando a una subnet privada para evitar ataques DDoS

- Aqui hay unos servicios que pueden ser similares pero tienen diferencias
  - CloudTrail: API level monitoring, logs the calls, Who Made What changes, IAM level monitoring
  - AWS config: Records config level changes, inform what changes are made, notifies regarding changes made in your accounts
  - Cloud Wach: Monitors performance, Future prediction & Analisis

- Nitro Enclaves proveen es como una maquina virtual dentro de una maquina virtual, aisla procesos para mantener seguridad, nisiquiera el EC2 en el que se creó se puede acceder a esta instancia

- Lo mas sencillo para comunicar distintos EC2 seguramente es agregar roles o permisos para la tarea, no tanto manejar credenciales o key managers

- Parece que los Elastic Kubernetes services suelen tener propiedades de emision de logs pero no leen info por seguridad
- El Pod execution role permite individual pods to assume an IAM role and access AWS services directly without going thorugh the node IAM role
- Self managed nodes for EKS te permite tener control sobre todo el proceso de EKS al contrario de un servicio administrado por AWS

- Existen automatic image scanning in th ECR repository, que te permiten analizar para buscar vulnerabilidades

- Se pueden optimizar gastos si haces un esquema hibrido, en el que tareas cortas constantes se pagan con Spot instances, y variables y largas con On-demand

- Para evitar mayor que las funciones hagan timeout para cargas grandes se puede dividir payload en chunks pequeños y que sean procesados por distintas lambdas invocations

- Event Bridge te ayuda a triggerear ejecuciones de lambda functions escuchando eventos importantes

- Existe el serverless application repository con librerias o aplicaciones pre construidas para ayudarte en algunos problemas o para apps, solo tienes que verificar el codigo y que se adiera a tus necesidades o seguridad requerida

- AWS Amplify automaticamente encripta data at rest y data en transito sin configuraciones adicionales
- Un outpost se puede poner dentro de la network on premise de la empresa

- Solo PostgresSQL soporta native autnehntication y kerberos

- Se prefiere usar memory-optimized instances de RDS para apps que en ciertos momentos tienen spikes de trafico como navidad, estas se prefieren por encima de las burstable

- La metrica mas importante para ver el performance de tu base de datos

- Performance Insights te ayuda a analizar y optimizar SQL queries
- Las RDS no tienen que usar CloudWattch para los logs, se puede guardar los logs directamente de la RDS consola, incluso en algunos casos guardarlos en un S3
- Pudes usar RDS Event subscriptions para lanzar mensajes en ciertos escenarios via SNS
- Para encriptar data o en general las preguntas relacionadas a aws usan KMS para guardar la info dentro de la base de datos, para data en transito se usa SSL/TLS

- Amazon Aurora divides your database volume into 10GB segments spread across many disks with each 10GB chunk of your database volume replicated six ways across three Availability zones

- NO se usa SDK integration para traer data a la RDS, se usa una integración automatica que rota las credenciales

- No tienes que poner la base de datos en otro VPC, es un overkill pueden estar en el mismo servidor

- Para detectar y asegurar compliance de regulaciones financieras puedes usar el Amazon Aurora Database Activity Streams

- Aurora DB puede usar SSL/TLS para transmitir data de manera segura

- Existe el RDS proxy que te permite funcionar como un load balancer (mas o menos) para optimizar el trafico de tu base de datos


# Investigar
Que es un Transit gateway
- Que es un privatelink
- Que es un VPC endpoint - Creo es un private endpoint, la gente puede conectarc eprivadamente
- Que es un VPC Interface Endpoints
- Que esAmazon FSx?
- Que es un Gateway Endpoint for S3 y un Inteface endpoint for S3
- Que diferencia hay entre Legal Hold y Vault Lock en aws backup
- QUe es el governance mode?
- Que es Amazon S3 File Gateway
- Que es Amazon FSx FIle Gateway
- Que es AWS Gateway Tape
- Que es AWS Storage Gateway Volume Gateway
- Que es un Bastion Host
- Que es AWS System Manager (o tambien AWS System Manager Fleet Manager)
- Que son las EC2 Instance Roles
- Que es un Certificate Authority
- Que es UEFI Secure Boot y Measured boot with NitroTPM
- Que es AWS lightsail
- Que diferencia hay entre un Application Load Balancer y un Network load balancer y por que se suele usar HTTPS en el ALB
- Que es Fargate
- Que es ECR
- Que es AWS Batch
- Que es AWS GuardDuty
- Que es un Outpost?
- Que es AWS RedShift?


# Preguntas a revisar
Turning up Security on network services - part 3
- 9:12