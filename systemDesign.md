Conceptos

Vertical scaling: aumentar la potencia del servidor
Horizontal scaling: Aumentar la cantidad de servidores, agrega redundancia y fault tolerance

CDN: se usan para acercar la ubicacion fisica al cliente final
Caching: crear copias de informacion que puedan ser refetcheadas rapidamente

TCP / IP: Es el internet protocol, tambien esta UDP, TCP es el protocolo estandard de enviar headers body en un paquete de forma cual se pidan los paquetes necesarios si se llegan a perder

UDP: a diferencia de tcp es mas rapido pero se pueden perder paquetes y pueden llegar en desorden o repetidos se usa en Streaming, videollamadas o voidIP, gamingOnline, DNS, DHCP

Domain Name System: se usa para hacer una record con un nombre y con un address para el nombre

El modelo mas comun es cliente y servidor

HTTP: usa headers metadata y un body, con HTTP hay distintos tipos de patrones el mas comunes son
REST: con metodos y todo
tambien está Graphql: Que pide solo la informacion que se va a usar
gRPC: hecho por google, es una mejora sobre REST, es para comunicacion entre servidores pero tambien entre cliente y servidor, usa protocol buffers la data es serializada en formato binario, envia data mas rapido, pero es menos leible que REST

WebSockets: Evita que andes pidiendo informacion muchas veces, o hagas un get a cada momento cuando recibes mensajes, establece una coneccion y cuando hay eventos se envian los cambios

SQL: te ayuda a obtener data mas rapido usando b-trees, la data se organiza en tablas, son ACID complient, ofrecen durabilidad, Isolacion (las transacciones no interfieren con otras), Atomicidad: cada transaccion es todo o nada, consistenci, las foreign keys estan obligadas

NoSQL: hay distintos tipos de bases de datos que no son SQL, orientadas a documentos, key-value, y basadas en grafos

Sharding: se puede dividir la base de datos en distintos ordenadores, pueden seguir el patron de lider folower, para replicar data, tambien hay lider lider, se usa un shard key el cual clasifica el valor y a donde pertenece

> Las base de datos solo pueden cumplir dos de estas habilidades, Consistencia, Availability, y Partition
Los 3 posibles compromisos:

CP (Consistencia + Partición):
Prefieres consistencia, incluso si sacrificas disponibilidad.
Si hay una partición en la red, el sistema puede rechazar peticiones hasta volver a sincronizar.
Ejemplo: MongoDB (configuración fuerte), HBase, Zookeeper.

AP (Availability + Partición):
Prefieres disponibilidad aunque pierdas consistencia temporal (eventual consistency).
Si hay partición, cada nodo sigue respondiendo con la info que tiene, y después sincronizan.
Ejemplo: Cassandra, DynamoDB, CouchDB.

CA (Consistencia + Disponibilidad):
Teóricamente posible solo sin particiones (es decir, en un sistema centralizado o en una red perfecta).
Como en la vida real siempre hay riesgo de particiones, en la práctica no se puede garantizar CA en sistemas distribuidos.
Ejemplo: una base de datos relacional clásica en un solo servidor (PostgreSQL, MySQL).

> Puedes usar CloudWatch para checar si estaba caido un servicio, por ejemplo un cambio de un group o permisos puede causar que dos servidores no se conecten

# Reglas a seguir
- Mantener backups y trata de evitar single points of failure


# Arquitectura de software
Las reglas de la arquitectura del software tienen como objetivo conseguir un software escalable

## Que es una capa
- Las capas son una abstraccion no tangible, no se compone de codigo o archivos, si no una separacion de responsabilidad, donde

> Presentacion: Aqui puede ir el web, puede ir tambien la version mobile
> Data: Puede ir ORMs, Raw SQL
> Dominio: Donde estan las reglas del negocio: Facturacion, ventas

## Que es un componente
- Un componente es un grupo conjunto, o elemento que se conforma de un conjunto de funcionalidades en común, puede ser una biblioteca DLL o una clase, puede ser un componente de ORM, puede haber uno para gestionar el caché, tambien puede haber un componente para Log, una analogia de que es un componente, es que en una plaza la zona de comida es una capa y los puestos son componentes

# Pasos a seguir cuando haces un system design

1. Obtienes functional requirements
  - Ves input y output

2. No functional requirements, por ejemplo ver si tiene que cumplir con CAP o tener resiliencia

3. Hacer metricas, cuantas veces se va a hacer algo

4. Profundizar en que tipo de valores va a recibir el input

5. Ver posibles edge cases

6. Diseñas el diagrama de los servicios

7. Diseñas posibles endpoints

8. Verificas seguridad, puedes serializar o sanitizar cada input del usuario

9. Se puede hacer un rate limiting para que cada request se ejecute con un maximo de veces por minuto

# Detalles extras comunes
- Mantener servicios stateless
- Tener multiples instancias de cada servicio
- Dispersar servicios a lo largo de varios data centers
- Monitorear queries per second, para hacer predicciones
- Many read replicas
- Eliminar posibles single points of failure

- Notification services
- Metadata Information
- Cachear informacion
- Usa Analitic services en ciertos puntos

- Usar distintos tipos de contenedores S3
- Comprimir Informacion
- Guardar info en CDNS

- Cada proceso puede tener distintas arquitecturas

## Otras preguntas que se suelen hacer al entrevistador
- ES publico o privado
- Necesitan analiticas
- Cuanto se espera que sea la escala
- Que usuarios lo van a usar y que tipo de usuarios


# Pros y cons
- Horizontal: Da menor consistencia o mayor complejidad y capacidad de fallar pero mayor escalabilidad
  - Vertical: Mayor simplicidad menor escalabilidad

- GraphQL:
  √ Un solo endpoint, obtienes lo que pides
  x Mas complejo, problemas de performance y de caching
- REST
  √ Simplicidad, caching, madurez
  x Overfetching o underFetching, mas dificil versionamiento

- Stateless
  √ Escalabilidad alta, simplicidad, tolerancia a fallos
  x Un sistema externo tiene que manejar el estado, Requiere reenviar contexto en cada token
- Stateful
  √ Simplificado de logica, menos trafico de datos repetidos
  x Menor escalabilidad, mas fragil, maneja 

- Read through cache
  √ Transparente para la aplicacion, siempre se pregunta a cache, reduce carga en DB en accesos repetitivos
  x el primer acceso es lento, si el dato cambia mucho puede ser inconsistente
- Write Through cache
  √ El cache siempre esta actualizado, los reads son rapidos y consistentes
  x Cada write es mas costoso, puede ser ineficiente si los datos cambian mucho

- ASyncrhonous proceses
  √ Mejor experiencia y rendimiento en general
  x mayor complejidad, requiere colas y estrategias para manejar errores


# Shortening URL notes
- Calcular el tamaño se saca con numero de shortenings x segundo, esto se multiplica para sacar cuanto se saca en 10 años y se crea una cantidad de letras mayor a la cantidad esperada de urls en esos 10 años por ejepmlo 7 o 10, ya que son miles de millones

- Para evitar colisiones o generar malas llaves se puede, pre generar las 3.5 trillones de urls, y guardar, se les asigna un null value y se empiezan a popular poco a poco

- Puedes usar una base de datos de postgres para asignar posibles urls y sus usuarios que son dueños de ellas, despues con el ID traer la data de una base de datos NoSQL

- Para informacion usada recurrentemente podemos usar bases de datos de Cache como redis

- Se puede hacer shardening a cada base de datos

# Bases de datos
- Cassandra suele ser usada para logs, escalabilidad horizontal ilimitada, mejor sistema distribuido, alta disponibilidad, optimizado escritura sobre lectura

# Whatsapp
- Vas a ocupar un notification service, que manda notificaciones
- Un presence service, el cual escucha heartbeats de cada usuario en el grupo para ver si esta conectado actualemente y notificarlo al cliente, usan PresenceDB como CassandraDB
- Tambien usas userService para autentificar, un Media service el cual trae la informacion de un S3 bucket los cuales se pueden mandar a un glacier

# Twitter
Scale: 20 million DAU
Average: 5 tweets per day
100 million tweets * day = 1000 tweets/second
100 million * 100 bytes = 10 GB / day * 365 * 10 years = 37TB

Endpoints:
POST /tweet
GET /feed

Method: Graphql, no traer demasiada data instead off get for every endpoint

Para traer la data se usa un proceso llamado FANOUT, existen dos metodos de FANOUE el pull y push cada uno con sus pros y contras, suelen usarse por ejemplo push para usuarios no tan importantes y el pull para gente importante

Detalles Arquitectura
Para el usuario y recomendaciones se usa una base de datos de grafo, se puede usar caché
Un News Feed service -> cache -> base de datos
Un tweet service con cache, -> notification service -> Analytics service

# Dropbox
Cliente: Checa un directorio y manda la informacion sincronizandola

User Service - Con su base de datos y servicios analitica
Block service Encripta la data -> ContentStorage S3 -> Cold Storage
Metadata Service, nos ayuda a trackear que informacion se mantiene sin usar -> Metadata Cache | DB
  Metadata manda a un -> Queue -> Notification service

# Instagram
API design
POST /api/upload, user_id, payload
GET /api/post/{postId}
GET /api/feed, user_id, pagination

Uploading content
Cliente -> Gateway -> Load Balancer -> Post Service
                                       -> Object Storage S3 -> CDN
                                       -> Postgres database with Metadata
                                          -> Kafka
                                             -> Neo4j
                                             -> Indexes
                                             -> User Feed Service
                                                -> User Feed DB
                                                -> User Feed Cache

Getting Content
Gateway -> Load Balancer -> User Feed Service
                            -> User Feed DB
                            -> User Feed Cache

Se suele utilizar el metodo de FANOUT para notificar a cada usuario suscrito cuando se hace upload de contenido, existe pull model y push

# Tinder
Los usuarios se pueden almacenar en Geo sharding por cada area, lo cual mejora el performance de las personas

Arquitectura
Creating Profile

Gateway
-> User Service
   -> Object Storage -> CDN
   -> Users DB
      -> Location Service -> Kafka -> Workers
                                      -> Mapping DB - Mapping Cache
                                      -> Geoshards

Gateway
-> Websocket Server -> Swipes Queue -> Workers
                                       -> Swipe DB - Swipe Cache
                                       -> Likes Cache
                                       -> Notification Queue -> Notification service -< Websocket service

Recomendations
Gateway -> Recomendation service -> Location Service
                                    -> (Mapping DB | Cache)
                                    -> Geoshards
           -> (Swipe DB | caché)

Updating Location
Gateway -> Location Service -> Workers Mapping DB Cache and geoshards

# Amazon Ecomerce

Arquitectura

Product BrowsingFLow
Gateway -> Product Service
           -> Product Metadata (elastic search) | Product Cache
           -> Inventory Service -> Inventory database (cassandra)

Cart Management
Gateway -> Cart Service
           -> Inventory Service -> Inventory database
           -> Cart Database Dynamo | Redis

Checkout
Gateway -> Order Service
           -> Inventory Service -> CassandraDB
           -> Cart Database | Redis
           -> Selling service
              -> Stripe service
              -> Kafka -> worker
                          -> Order Postgres
                          -< Inventory service

# Airbnb
Adding Hotel
Gateway -> Admin Service
           -> S3 -> CDN
           -> Queue -> Admin consumer
                       -> Elastic Search Cluster
                       -> Hotel Database | cache
                       -> Notification queue -> Notification Service -> SMS | Email


Creating Reservation
Gateway -> Hotel Service
           -> Elastic Search Cluster
           -> Hotel Database
           -> S3
           -> Reservation service -> Billing service
                                     -> Strapi
                                     -> Reservation Postgresql
              -< Hotel service
              -> Notification service
