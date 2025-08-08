> La una de las claves para ver si podemos manejar 8 millones de peticiones es ver el throughhput de la base de datos, tener metricas y ver como se desempeña

> Tambien para tener backwards compatibility pues aqui tendria que hacer otro endpoint y que se mantenga el anterior, pero pues no sabia como mostrar eso

"Uno de los requerimientos mencionaba resiliencia y capacidad ante alto tráfico. Esto lo interpreté como una necesidad de escalar horizontalmente y preparar el sistema para redundancia. Aunque por tiempo no desplegamos un entorno distribuido, idealmente usaríamos un Load Balancer con múltiples instancias backend, mediríamos el throughput con herramientas como Artillery, y consideraríamos el uso de una base de datos en memoria como Redis si el volumen de lectura/escritura justifica ese salto de rendimiento. Todo esto con una arquitectura desacoplada que facilite escalar por servicio."

"¿Qué tipo de clínicas u hospitales son sus principales clientes? ¿Cuáles son los desafíos técnicos más comunes que enfrentan?"

"¿Cómo está estructurado su stack actual? ¿Usan microservicios, monolito, serverless?"

"¿Cómo se ve una semana típica para un desarrollador full-stack aquí?"

"¿Cómo colaboran los equipos de producto, diseño y desarrollo para lanzar nuevas funcionalidades?"

"¿Cómo miden el impacto de las nuevas funcionalidades desde el lado clínico o del paciente?"

Usan fastapi?

tienen equipo de diseño que rol tiene?

No usan metodologia agil