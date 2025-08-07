# Objetivos
Cloud Concepts
Security
Billing and Pricing
Tech and services

# Cloud computing

## What is cloud computing
Existen 3 modelos de computing
- Cloud
- On premise: o local, el metodo antiguo
- Hibrid

> Trabaja como un modelo Client-Servidor
> Provee acceso a recursos computacionales casi inmediatamente

## Que es aws
> Aws fue el primer provedor cloud en 2006 con S3 como el primer servicio
> Aws tiene la comunidad mas grande

## Beneficios de Cloud
Existen dos formas de pagar
> Variable Expenses (OPEX)
> Upfront Expenses (CAPEX)
> No te centras en mantener Data Centers
> Tienes escalabilidad, no tienes que adivinar que es lo que vas a necesitar, si necesitas mas se actualiza automaticamente
> Pagas lo que usas
> Tiene distintos data centers al rededor del mundo

## Economic Models in AWS
> Free Tier: Amazon tiene algunos servicios gratis por tiempos limitados, aunque hay unos que lo son por siempre
> On demand: Pagas por el tamaño de la potencia que vas a usar
> Reservations: Haces un compromiso de 1 año o 3, compras algo y prometes pagar durante un año o 2 y si se cancela a medio camino se queda asi
> Volume Discounts: A mas usas por ejemplo en S3, pagas menos por cada recurso utilizado

## Cloud design principals
> Diseñar para el error: Siempre ten en mente que va a pasar si falla la aplicacion que se hara, todo todo el tiempo
> Decoupling significa separar los componentes de un sistema para que no dependan fuertemente entre sí.
En una arquitectura loosely coupled, si un servicio cae, los demás pueden seguir funcionando porque no dependen directamente de él (por ejemplo, usando una cola de mensajes que almacena las peticiones).
En una arquitectura tightly coupled, los componentes están tan interconectados que si uno falla, puede arrastrar a todo el sistema.
> Elasticidad: Los servidores adquieren potencia si necesitan mas, y lo contrario
> Pararelismo: Se puede aumentar la velocidad de una tarea con mayor cantidad de servidores

In the AWS benefit called Trade Upfront Expense for Variable Expense, you often:

# Security
### 🔒 Seguridad y Cumplimiento

| Acrónimo | Significado | Descripción |
|----------|-------------|-------------|
| AWS | Amazon Web Services | Proveedor de servicios de computación en la nube. |
| IAM | Identity and Access Management | Servicio para gestionar identidades y accesos a recursos de AWS. |
| HIPAA | Health Insurance Portability and Accountability Act | Ley estadounidense que regula la privacidad de datos de salud. |
| HITECH | Health Information Technology for Economic and Clinical Health Act | Ley de EE. UU. para el uso seguro de tecnología de información en salud. |
| PCI-DSS | Payment Card Industry Data Security Standard | Estándar de seguridad para datos de tarjetas de pago. |
| OU | Organizational Unit | Unidad organizativa dentro de AWS Organizations para agrupar cuentas. |
| SCP | Service Control Policy | Política de control de servicios que limita acciones de cuentas u OUs. |

---

### 🔧 Recursos y Protección

| Acrónimo | Significado | Descripción |
|----------|-------------|-------------|
| WAF | Web Application Firewall | Firewall que protege aplicaciones web contra ataques como SQL Injection y XSS. |
| XSS | Cross-Site Scripting | Tipo de ataque de inyección de scripts en aplicaciones web. |
| DDoS | Distributed Denial of Service | Ataque distribuido que busca sobrecargar un servicio. |
| VPC | Virtual Private Cloud | Red virtual privada dentro de AWS para aislar recursos. |

---

### 🔍 Detección y Monitoreo

| Acrónimo | Significado | Descripción |
|----------|-------------|-------------|
| GuardDuty | *(Servicio AWS)* | Detecta actividad sospechosa y amenazas. |
| Detective | *(Servicio AWS)* | Investiga eventos de seguridad. |
| CloudTrail | *(Servicio AWS)* | Registra la actividad de API y usuarios. |
| Config | *(Servicio AWS)* | Rastrea y audita configuraciones de recursos. |
| Security Hub | *(Servicio AWS)* | Centraliza alertas y valida mejores prácticas de seguridad. |
| Security Lake | *(Servicio AWS)* | Recolecta logs y los transforma para consultas eficientes. |
| Macie | *(Servicio AWS)* | Escanea S3 para encontrar datos sensibles. |

---

### 📋 Gestión y Administración

| Acrónimo | Significado | Descripción |
|----------|-------------|-------------|
| HSM | Hardware Security Module | Módulo de hardware para almacenar y operar claves criptográficas. |
| SSL/TLS | Secure Sockets Layer / Transport Layer Security | Protocolos de seguridad para cifrar comunicaciones. |
| KMS | Key Management Service | Servicio para crear y gestionar claves de cifrado. |



## Shared REsponsibility Model
Aqui aws se encarga del SOftware, computacion storage databases networking hardware, pero nosotros nos encargamos de la plataforma IAM las applicaciones sistema operativo el firewall y la encripcion

## Security and Compliance
> La compliance es cuando te adieres a leyes de financas salud y leyes federales, como HIPAA HITECH PCI-DSS, AWS tambien se adhiere a estas reglas
> AWS tiene certificaciones y audita para ver si se alcanzan las regulaciones
> Los reportes de los audits estan disponibles en AWS Artifact
> AWS Artifact tambien permite a los clientes leer y aceptar y trackear estas regulaciones
> AWS Compliance Center es una locacion para investigar regulaciones sobre la nube y el impacto en tu industria, identificas requerimientos regulatorios, buscas leyes especificas por pais, descubres como las empresas resuelven esto, te dan respuestas a preguntas, auditan y muestran mejores practicas
> Existe Audit manager que recolecta informacion para preparar para la auditoria y se asegura que tu compañia cumple con los estandares regulatorios
> AWS Config, trackea como el recurso es configurado y guarda previas configuraciones y te permite ver como las configuraciones han cambiado durante el tiempo

## Identity Access Management
> Root user has unlimited access and no restrictions
> IAM is responsible for managing access to AWS resources
> AN Iam user represents a person or application that needs to access to AWS or a subset of services
> Policies are documents that either grant or deny access to specific AWS services/resources
> Groups are a collection of IAM users
> Roles allow a user to get temporary access to a service o resource
> Least-privilege permissions Grant users or entities the minimum level of access required to perform their specific tasks

## Organizations
> Organizations help manage multiple AWS accounts
> Organizational units (OUs) allow you to group accounts with similar busines or security requirements
> Service Control Policies (SCPs) restrict what an account can do
> SPCs can be applied to individual accounts or OUs

## Resources for Security
> WAF Protects applications from attacks like SQL injection and XSS attacks
> Shield protects from DDoS
> Network Firewalls monitor traffic entering and leaving VPCs

### Detection
> GuardDuty Monitors and detects suspicious activity and potential threats in your AWS environment
> Detective helps analyze and investigate security-related events by collecting and visualizing data
> CloudTrail logs and monitors all user and API activity within an AWS account 
> AWS Config tracks and audits the configuration of AWS resources over time
> Security Hub automates security checks and brings alerts to a central location. Alos performs validation on AWS best practices
> Security Lake collects logs from a variety of locations and transfrosm them into a query efficent format
> AWS Macie scans S3 buckets for sensitive data and notifies users of findings

### Management
> FIrewall Manager helps manage security configuration accross multiple accounts
> Resource Access Manager, helps securely share resources across accounts organizations and organizational units
> Cognito provides authentication authorization, and user management for web and mobile applications
> IAM enables to manage your user identitis ant their access to AWS resources
> Identity Center provides central location for managing user authentication across multiple AWS accounts
> Secrets Manager allows you to securely store and manage sensitive information like passwords and credentials
> AWS Certificate Manager, provisons manages and deploys SSL/TLS certificates for AWS resources
> Private Certificate Authority manages your own private certificate authoriti within AWS
> KEy Management Service creates and manages encryption keys used to encrypt data
> Cloud Hardware Security Module (HSM) - AWS provides a dedicated hardware to store and operate cryptographic keys

# Technology part 1

## CLI
> La estructura general de los comandos es $ aws [service] [command] [options], ej $ aws s3 mb s3://my-bucket

## SDK
> El sdk se usa en las aplicaciones para que ellas interactuen con aws, como si manejaran la terminal

## Regions
> NO todas las regiones tienen los mismos servicios
> Cada region tiene distintos precios
> Cada region tiene Availability zones que son data centers que proveen redundancia para evitar caidas, tienes que desplegar tus aplicaciones en cada availability zone
> Puedes desplegar tu aplicacion en una locacion principal y desplegar aplicaciones en Global Content Delivery & Edge locations, que te ayuda a distribuir en pequeños servidores tus servicios a modo CDN's
> Local zones son extensiones de las AWS regions, permite seleccionar algunos servicios de manera mas cercana a los usuarios, se diferencia en que las Local zones son extensiones de las regiones cercanas a grandes ciudades, Edge locations no tienen una region padre a la que estan ligadas, tienen servicios limitaos y no proveen todos los servicios

## Networking
> VPC isolates computing resources from other computing resources available in the cloud
> You can have multiple VPCs
> VPC are isolated to a region
> VPC CIDR block defines the IP addresss a VPC can use un CIDR es un rango de IP que tiene cada VPC, puedes conectar servicios externos a AWS via VPN, cada subnet tiene que estar dentro del rango del CIDR
> SUbnets are a range of IP addresses within a VPC
> Subnets reside within a single Availability zone
> Subnets can be made public/private using internet Gateways & Nat Gateways
> Por ejemplo las subnets privadas pueden ser usadas para bases de datos
> Internet Gateways allow subnets to communicate with internet & Viceversa
> Nat Gateways allow subnets to talk to the internet but must be initiated from within the VPC, if you receive something external first it will be blocked
> Virtual Private Gateway enable secure access to private resources over the internet
> Direct COnnect(DX) is a direct connection into an AWS regions that provide low latency secure + high speeds

## VPCs
> Every region has a default VPC with default subnets security groups and NACLs
> THe CIDR block for default is 172.31.0.0/16
> The default VPC and its subnets have to outbound access to the internet by default
> One default subnet in each AvailabilityZone
> THe security groups allow outbound and the NACLs are open in both inbound and outbound directions

## Firewalls
> Stateles firewalls require traffic to be explicitly permitted, inboun and outbound
> Stateful firewalls are intelligent firewalls tha track requests and allow responses
> Network ACLs filter traffic entering & leaving subnet
> Network ACLs are stateless firewalls
> Security groups act as firewalls for individual resources such as EC2, NICs, and other network objects

# Storage

## Types of storage
### Block Storage
- Presentado como un file system
- A collection of blocks can be presented to the OS as a volume
- EBS Volumes can be mounted & booted > puedes usar otros sistemas operativos
- EBS Volumes are within an Availability Zone
- INstance Stores are removed when EC2 instances are stopped/started

### File Storage
- Como EFS guarda data en un sistema de folders
- Pueden ser montados
- No puedes instalar un sistema operativo en el
- Es accesible via la network
- Multiples clientes pueden acceder a la misma data

### Oject Storage
- Guarda datos al estilo dropbox
- No hay estructura de folders, solo son archivos
- No se pueden montar o bootear
- Es bueno para logs y media

### Storage classes
- Hay distintos tipos de storage classes en s3
  - Standard: Es la mas cara, puede manejar dos availabilities zones a la vez, tiene 99.9999 durability, te cargan el numero de gigabytes usados, la data que es enviada tambien se cobra, es el tipo comun para paginas web o lugares que requieren uso inmediato de la data
  - S3 Standard-IA: Infrequent access, es mas barata, puede manejar dos AZ a la vez, sigue el mismo tipo de modelo de pagos que el modelo standard, extraes data de ellos gratuitamente, si usas la data mas frecuentemente puede terminar siendo mas caro que el standard, esto se mitiga si usas archivos muy pequeños
  - One Zone-IA: Solo se guarda en una AZ, tiene baja resiliencia, es mas barata que los modelos anteriores, pagas por salida de datos, replications still ocurrs inside AZ
  - Glacier-Instant: tiene retrieval fee, muy barata pero con precios altos al retraer la data
  - Glacier-Flexible: la data no esta disponible inmediatamente, es aun mas barata que las demas clases, tiene retrieval fee, minimo tamaño de 40kb por objeto
  - Glacier Deep Archive, se usa para archivos que practicamente nunca son extraidos, es el mas barato de todos, tiene retrieval fee
- S3 Intelligent-Tiering, automaticamente reduce costos moviendo la data a el tier mas efectivo

## Computing
### Deploying an aplication
- Ya que no tienes contacto fisico con tu servidor AWS usa los Amazon Machine Image (AMI), los cuales son imagenes que proveen informacion requerida para hacer funcionar tu instancia
- Existen instances types, los cuales estan optimizados para cada tipo de uso, por ejemplo los General Purpose, Compute optimized, buenas para batch procesing, machine learning, gaming servers, memory optimized para bases de datos, y storage optimized, para leer y escribir, y Acelerated Computing, buena para procesamiento de graficos
- Existen distintos precios para los servidores
  - On demand Pricing, pagas por la capacidad de computo por hora, solo se paga cuando corre, no upfront payment, buenas para corto plazo y workloads impredecibles, corren en shared hosts
  - Spot Pricing: AWS usa la computacion que les sobre para usar el 100% de la maquina y hace ofertas, son recomendados que necesitan bajos precios de computacion, que tienen starts y ends flexibles, no son buenas para sistemas que no toleran interrupciones
  - Reserve Pricing: Firmas un contrato a largo plazo, es mas barato si el periodo es de 1 a 3 años, no te da un servidor solo, solo es un compromiso a usar una instancia por un largo plazo, no el servidor entero
### Lambda
- En una aplicacion normal tienes que desplegar en un EC2 instalar los AMIS y dependencias, asegurarla setear el firewall, permitir trafico, copiar y pegar el codigo de la app, durante el tiempo tienes que hacer mantenimiento
- Con lambda solo subes tu codigo y aws maneja el resto, esto es llamado serverless offering, AWS maneja el mantenimiento scaling, la capacidad y el logging, el que sea serverless no significa que no uses servidor, lo que significa es que no usas ninguno
- Se usa para procesos triggereados por algun evento, trae recursos y cuando termina regresa los recurso
- SOn buenos para procesar archivos, para procesar stream, web aplications, mobile o web backends
- Esta compuesto por una lambda function en cualquier lenguaje
```js
exports.handler = async function(event, context) {
  // Event recibe el evento escuchado
  console.log("Lambda function ran")
  return
}
```
- requiere un trigger, por ejemplo subir un archivo a S3 hacer un request a un Gateway, DynamoDB updates, esta al pendiente de archivos
- Pagas solo lo que usas
- Sus downsides son que no tiene local state, necesita un servicio externo para eso, tiene un limite de duracion, dura solo 15 minutos despues de eso se termina su ejecucion
- Tiene algunos issues de cold start
- Pricing, suele cobrar el numero de veces que la funcion corrió, por cuanto duran, y cuanto cpu o memoria requiere

### ECS & EKS
- Un contenedor es una herramienta que te permite guardar una aplicacion los archivos librerias y dependencias que la aplicacion necesita para correr
- Se suele necesitar un manejador de contenedores para balancear las requests, si una app falla creas un contenedor, si el host falla mueves contenedores a otros hosts, para esto se usan Container Orchestrators deployean contenedores, hacen load balancing, dan conectividad, reinician contenedores caidos
- Suelen usarse Kubernetes, Apache Mesos y ECS
- ECS es un container orchestrator, es manejado por AWS, no lo tienes que usar, los Containers corren en EC2 instances or Fargate, ECS es privado a AWS
- Kubernetes es un orquestrator open-source, Kubernetes tiene dos tipos de nodos, Control-Plane Observa el cluster y asegura que el cluster se mantiene en un estado de trabajo, tiene worker nodes responsables para correr los el codigo
- Elastic Kubernetes Service (EKS), le da el control a la persona, con Fargate AWS maneja los nodos
- Los beneficios de correr EKS, te permite escalar el control-plane atraves de distintas availability zones, escala el control-plane basado en la carga, puede integrar con otros AWS services, IAM, Elastic load Balancery ECR
- ECS vs EKS: Ecs te hace dificil migrar de aws, ECS tiene arquitectura mucho mas sencilla, ademas de aprender kubernetes necesitas aprender caracteristicas especificas de EKS, kubernetes tiene una mayor comunidad y herramientas, ECS es mas barato


# Databases
## Core AWS Services
- Existen distintos tipos de bases de datos
  - Self managed Datastores
  - SQL Datastores
  - NoSQL DataStores
- Self-Managed Database summary
  - Can run your own database software on EC2 or any container services ECS or KES
  - Increase control and Flexibility
  - Increased Operational overhead and Responsibility
  - Mainly used when you need have specific software security requirements

### SQl Datastores
- Quieres un carro rentado 24/7 con un conductor, vienen en 5 variantes, cada pasajero tiene asientos asignados: Relational Database Service or RDS, mySQL MariaDB, PostgreSQL, Oracle instance
- Quieres lo mismo pero un carro de lujo super rapido lujo, 2 variantes: SQL Datastore - Aurora, RDS Aurora, Mysql Postgresql
- QUieres rentar un carro solo para una tarea, tiene conductor, no eres responsable de lo que pasa, tiene dos variantes, cada persona tiene un asiento, pero solo es un servicio por ride: SQL Datastores - Aurora Serverless v2, PostgreSQL MySQL, paga poco por storage pero no computa cuando no se usa, capacidad puede variar mas facil que otros servicios
- Quieres rentar un autobus con un conductor, eres responsable por el interior del autobus, solo tiene una variante, casa pasajero tiene un asiento: SQL Datastores - Redshift, viene con postgres, cuando necesitas un data warehouse no una transactional data store, petabyte scale, SErverles y server version, Think Reporting and not E-commerce or web traffic, te da relational reporting
- Amazon MemoryDB for redis,

### NoSQL datastores
- DynamoDB, es el flagship de NoSQL, guarda informacion clave-valor, te da acceso rapido a Blobs Unestructurados
- DocumentDB, te sirve para guardar documentos, ensayos perfiles que son mas como colecciones de datos, usa mongodb
- Amazon Keyspaces: Para apache y Cassandra, te da bases de datos distribuidas a lo largo del mundo, con informacion no estructurada que requiere ayor estructura para ellos
- Amazon Neptune: Te da una base de datos que detecta relaciones entre data, como deteccion de fraude o relaciones sociales en redes sociales
- ElastiCache: Necesitas guardar informacion mas rapidamente que una base de datos normal
- Amazon OpenSearch Service, te permite buscar a traves de mucha informacion, como google search que te da informacion relevante o relacionada
- Amazon Quantum Ledger Database: Quiero una base de datos en la que cada vez que se modifica algo, queda registro de ello, guarda datos inmutables
- Amazon Timestream: Cuando quieres obtener data de distintos recursos a gran escala y mantiene time stamps, util para IoT

### AWS Application integration
- Simple Notification service duplicates multiple messages to many different sources like email text other applications etc
- Simple QUeue system is built to receive messages and hold them for processing
- Amazon AppFlow Solves the problem of copyint data from 3rd parties like salesforce into AWS
- Amazon MQ alows to manage Queues opensource instead of AWS SQS
- Amazon Step Functions Solves the problem of how do I organize my serverless functions so they can work like a full application
- Amazon event bridge Acts like a post office for coordinating events across applications
- Elastic Load Balancing is a network traffic distribuitor
- Autoscaling handles add and removing capacity whhether servers or read/write units

### Management Services
Services that help manage other services
- Cloud Formation, te ayuda a crear otros servicios usando archivos, no necesitas introducir comandos, solo pasas un archivo y crea la estructura completa
- AWS OpsWorks, te permite crear software layers para cada nivel que vas a usar, tipo Web, App, y DB
- AWS Systems Manager, te permite manejar la estructura
- AWS Organizations: Manejas todas las cuentas como si fuera una sola, te permite gobernar todo desde una sola ubicacion, se maneja la seguridad y billing
- AWS Service Catalog, Allows to take your CloudFormation and Terraform creation templates and turn them into a vending machine for your users on AWS
- AWS Control tower Allows you to set up AWS Organizations in a sercure best practice way with auditing logging and compliance rules in place <<<
- AWS Config, AWS CloudTrail Para auditar actividad sospechosa en las cuentas de aws
- Launch wizzard, Guide for installing non-aws apps like SAP
- License manager: Allows you to track your licences in AWS from other companies
- Computer Optimizer,: Tells you when you are being inefficient in AWS with compute
- Trusted Advisor: A best practice advisor tells you when you are not following best practices
- Resource Explorer, Allows you to search and discover your resources in AWS
- REcource group and Tag editor: Group tag and manage your services
- AWS Resilience Hub, AWS service provides a unified view of your operational health and performance monitoring across multiple AWS resources

### Migration and Transfer on AWS - Overview
- AWS Migration hub, Allows you to centralize and see al migration you have in place via AWS services
- AWS tiene 6 metodos o patrones para migraciones
  - Rehosting (Lift-and-Shift), solo tomas un servidor y lo mueves a aws, a veces nisiquiera cambias OS copias y pegas, mas facil y rapido
  - Replatforming (Lift, Tinker, and Shift): Mueves a un sistema operativo o base de datos mas avanzada, cambios moderados
  - Rearchitecting/Refactoring: Refactorizas, reimaginas la arquitectura de tu aplicacion entro de aws, tienes la mayor cantidad de beneficios de AWS
  - Repurchasing: Consigues una licencia y compras nuevas versiones usando AWS, para productos de microsoft por ejemplo
  - Retaining: Practicamente no hacer nada,  mantener tu servidor igual
  - Retiring: Esperar a que tu servidor desaparezca
The snow family: AWS te manda una maleta robusta para pasar informacion fisica a el y ahorrar envio por internet, tiene bastantes medidas de seguridad
  - Snowbal Edge Storage Optimized, te da small compute, tamaño medio, transferencia de 80TB
  - Snowball Edge Compute Optimized: Medium compute, small data, portable compute
  - Snowmobile: No compute, Large data: 100PB of data
  - Snowcone, Small compute, Small storage, Portable compute
Transfer Family for FTP
AS2 Family suports using AS2 to send and receive messages using s3 as backend
- Data sync is a secure online service that automates and accelerates moving data between on premises and AWS Storage services
- Application Discovery service: What can I use to discover information about apps I am migrating,
- Application Migration Service: What can I use to migrate applications to AWS
- Database Migration Service - What can I use to migrate databases to AWS?
- Elastic Disaster Recovery: Fast reliable Recovery
- Mainframe Modernization: WHat can I use to migrate mainframe components to modern AWS services

# AI
- Sagemaker te ayuda a entrenar modelos de machine learning
- Lex - te ayuda a hacer chatbots
- Kendra: Te ayuda a buscar productos, muy precisamente a comparacion de otras opciones, usa machine learning, mejora productividad
- Amazon Comprehend: Consigue insights para encontrar relaciones dentro del texto
- Amazon Polly: busca mimificar la voz humana, convierte texto en discurso
- Amazon Rekognition, analiza imagenes y videos y te dice que hay en los videos, tiene analisis facial objetos, usa deep learning video y facial analisis
- Amazon textract: Machine learning para extraer data formar y puede formar tablas, te ayuda a analizar por ejemplo texto de doctores
- Amazon Transcribe: convierte audio en texto
- Amazon Translate: Te ayuda a traducir entre idiomas

# AWS Analitic services
- Amazon athena: Un telescopio que te ayuda a hacer zoom a elementos en s3, importa data lo pone en un SQL en memoria, ayuda a logs analysis, Data lake queries
- AWS data exchange: Aqui se puede comprar o vender data, se puede monetizar lo que haces
- Amazon EMR map reduce: Ayuda a hacer big data compilation, ayuda a data analytics data transformation
- AWS Glue: toma toda la data dispersa  yte ayuda a conectarla, como hacer una constelacion
- Amazon Kinesis: Similar a kafka, te ayuda a hacer streaming de data en tiempo real
- Amazon MSK: te permite usar kafka, real time analytics y data ingestion
- Amazon OpenSearrch Service: es mas extenso que kendra
- Amazon Redshift: Data warehouse telescope

# AWS Business Application Services - Your Personal Business Toolkit
- Amazon Simple Email Services: un comunicador de negocio, marketing transactional emails, es como tu post office personal
- Amazon Connect - Customer Service desk se conecta a backnds sistems o CRMS o AWS services

# Customer Engagement Services
- AWS Activate for Startups: ayuda financiando posibles startups
- AWS IQ: Te conecta con expertos en el uso de AWS
- AWS Managed Services (AMS), ayuda a el management operacional y infrastructure management
- AWS Support

# Preguntas fallidas
Which of the following features allows you to apply policies and settings across multiple AWS accounts in AWS Organizations?
What is the primary purpose of Amazon GuardDuty?
Which of the following statements accurately describes AWS Organizations?
Which of the following types of security assessments does AWS Inspector provide?
What is the primary difference between managed and unmanaged services in AWS?
What is the primary purpose of Amazon Macie?
What is the main purpose of AWS Firewall Manager?
What is the main purpose of Amazon Cognito?
What is AWS CloudFormation Primarily used for?
What is OpsWorks
What is the primary purpose of AWS Systems Manager Automation
What is the primary purpose of AWS DataSync
What is AWS Athena


# Servicios a investigar
AWS Batch
AWS Elastic Beanstalk
AWS Auto Scaling
ACL
NAT Gateway
AWS direct Connect
NACLs
EBS


75