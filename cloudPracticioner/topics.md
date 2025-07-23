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


Preguntas fallidas

Which of the following features allows you to apply policies and settings across multiple AWS accounts in AWS Organizations?
What is the primary purpose of Amazon GuardDuty?
Which of the following statements accurately describes AWS Organizations?
Which of the following types of security assessments does AWS Inspector provide?
What is the primary difference between managed and unmanaged services in AWS?
What is the primary purpose of Amazon Macie?
What is the main purpose of AWS Firewall Manager?
What is the main purpose of Amazon Cognito?