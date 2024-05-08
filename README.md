## Ruby Challenge

#### Tabla de contenidos

- [Requisitos funcionales](#Requisitos-funcionales)
- [Requisitos para ejecutar](#Requisitos-para-ejecutar)
- [Cómo ejecutar](#Cómo-ejecutar)
- [Consumir API Rest con cURL](#Consumir-API-Rest)


#### Requisitos funcionales
Objetivos:

Desarrollar un aplicación en Ruby o framework basado en Ruby que contemple una Task para obtener y persistir datos y una API que exponga dos endpoints que serán consultados desde un cliente externo.

Desarrollar una página web simple en HTML5 y Javascript que permita consultar los dos endpoints que expondrá la API mencionada anteriormente. Bonus si utiliza alguno de estos framework: EmberJS, React, AngularJS o VueJS.


1 Desarrollo Back end:

Se espera el desarrollo de una aplicación en Ruby o framework basado en Ruby que obtenga y entregue información relacionada con datos sismológicos en el mundo. A grandes rasgos se espera que contemple una Task para obtener y persistir datos y dos endpoints que serán consultados desde un cliente externo.


1.1 Obtención de datos desde feed y persistencia:

Desarrollar una Task que permita obtener data sismológica desde el sitio USGS (earthquake.usgs.gov). Este feed entrega data en el formato GeoJSON utilizado para estructuras de datos geográficas, por ejemplo un Feature (un evento sismológico), pero no te preocupes, GeoJSON usa el estándar JSON ;)

Específicamente se debe obtener desde el feed "Past 30 days" (https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson) la información de la colección features. Específicamente por cada elemento se debe guardar:

`id`, `properties.mag`, `properties.place`, `properties.time`, `properties.url`, `properties.tsunami`, `properties.magType`, `properties.title`, `geometry.coordinates[0]` (longitude) y `geometry.coordinates[1]` (latitude).

Es necesario persistir esta data en BD. Considerar:
Los valores de `title`, `url`, `place`, `magType` y `coordinates` no pueden ser nulos. En caso contrario no persistir.

Validar rangos para magnitude [-1.0, 10.0], latitude [-90.0, 90.0] y longitude: [-180.0, 180.0]

No deben duplicarse registros si se lanza la task más de una vez.


1.2 Disponibilizar datos a través de una API REST:

Se espera que se desarrollen dos endpoints para exponer la data y modificar data:

1.2.1 Endpoint 1: GET lista de features

Considerar:

Los resultados deben exponerse siguiendo el siguiente formato:

```
{
   "data":[
      {
         "id":"Integer",
         "type":"feature",
         "attributes":{
            "external_id":"String",
            "magnitude":"Decimal",
            "place":"String",
            "time":"String",
            "tsunami":"Boolean",
            "mag_type":"String",
            "title":"String",
            "coordinates":{
               "longitude":"Decimal",
               "latitude":"Decimal"
            }
         },
         "links":{
            "external_url":"String"
         }
      }
   ],
   "pagination":{
      "current_page":"Integer",
      "total":"Integer",
      "per_page":"Integer"
   }
}
```

La data debe poder ser filtrada por:

`mag_type`. Using filters[mag_type]. Puede ser más de uno. Valores posibles: md, ml, ms, mw, me, mi, mb, mlg.

`page`

`per_page`. Validar per_page <= 1000


1.2.2 Endpoint 2: POST crear un comment asociado a un feature

Este endpoint debe recibir un payload que considere la siguiente información para crear un comentario relacionado con el feature :

Considerar:

Un feature puede tener uno o más comments, pero solo se crea uno a la vez (por request).

El payload debe contener un `feature_id`: Integer que hace referencia al `id` interno de un feature y un `body`: Text con el comentario ingresado.

Se debe persistir cada comment recibido por este endpoint.

Se debe validar que existe contenido en el body del nuevo comentario antes de ser persistido.


#### Requisitos para ejecutar
Tener instalado:

- Docker Compose
- Git

#### Cómo ejecutar

Primero, clona este repositorio en tu máquina local:

```bash
git clone https://github.com/retaLazyCodes/ruby-challenge.git
```

Navega hasta el directorio del repositorio clonado:
```bash
cd ruby-challenge
```

Por último ejecuta el siguiente comando para iniciar la aplicación con Docker Compose:
```bash
docker-compose up
```

Una vez que los contenedores estén en funcionamiento, puedes acceder a la aplicación ingresando a http://localhost:3000 en tu navegador web.


#### Consumir API Rest

Obtener features:
```bash
curl --request GET \
--url 'http://127.0.0.1:3000/api/features' \
-H 'Accept: application/json' \
-H 'cache-control: no-cache'
```

Obtener features paginados y filtrados:
```bash
curl --request GET \
--url 'http://127.0.0.1:3000/api/features?page=1&per_page=5&mag_type=md,ml' \
-H 'Accept: application/json' \
-H 'cache-control: no-cache'
```

Crear un comentario de un feature:
```bash
curl --request POST \
--url 'http://127.0.0.1:3000/api/features/1/comments' \
--header 'content-type: application/json' \
--data '{"body": "This is a comment" }'
```



