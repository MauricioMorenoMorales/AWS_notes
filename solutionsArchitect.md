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

