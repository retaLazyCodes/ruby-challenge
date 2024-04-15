## Ruby Challenge

#### Tabla de contenidos

- [Requisitos para ejecutar](#Requisitos)
- [Cómo ejecutar](#Cómo-ejecutar)
- [Consumir API Rest con cURL](#Consumir-API-Rest)


#### Requisitos

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



