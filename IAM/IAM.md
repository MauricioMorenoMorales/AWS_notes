AWS Identity and Access Management

Una policy es una coleccion de permisos

Existen dos tipos de policys
Identity policies
  - Role
  - Group
  - user
Resource-based policies
  - s3
  - lamda

En las policies el deny lleva prioridad, todo tiene que especificarse con un allow explicito

# IAM permission boundaries
Establece el maximo numero de permisos que un IAM entity puede tener
Previene accesos no intencionales a los recursos

# IAM roles
los roles pueden asignarse a servicios y a usuarios

# Session policies
Se usan para otorgar permisos de manera temporal por un tiempo necesitado, 

# Cloudtrail
CLoudtrail registra cambios, eliminaciones o eventos importantes en el ciclo de vida de la app, hechas tanto por usuarios como por servicios

# Tipos de policies
A grandes rasgos hay 3 tipos de policies en aws
- AWS Managed policies: Por defecto en AWS
- Customer Managed policies: Las creadas por el usuario
- Inline policies: Policies hardcodeadas en las entidades

Las policies estan compuestas de
- Effect: Allow, Deny
- Actions: s3:GetObject, EC2:StartInstance
- REsources: arn:aws:s3:::name-bucket/*
- Conditions: Time of day IP
- Principal: Entity that the policy applies too

# Otras funcionalidades que tiene IAM
- Identity Federation: Te permite usar servicios de AWS con una cuenta ya creada anteriormente
- Private Link and VPC endpoints: Permite aumentar seguridad usando links privados

Cuando tienes que crear una serie de cuentas sigue estos pasos
- Creas cuentas para cada departamento
- HAbilita IAM management con AWS organizations para centralizar informacion
- Configura IAM cross account access
- Monitora acceso de usuarios usando Cloudtrail
- Setea alarmas para un recurso usando CLoudwatch
- Implementa seguridad en AWS config
- Usa IAM Anywhere
- Usa IAM Identity center

AWS: Organizations: te sirven para administrar diferentes cuentas al mismo tiempo, contiene:
- Centralized Billing
- Resource sharing
- Access Management
- Compliance
- SImplified Account Management

