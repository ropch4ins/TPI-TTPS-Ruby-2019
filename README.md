# TPI-TTPS-Ruby-2019
Trabajo práctico integrador para la asignatura: Taller de Tecnologias de Produccion de Software (TTPS) Ruby 2019 - Universidad Nacional de La Plata (UNLP)

### Profesores:
  - José Nahuel Cuesta Luengo
  - Christian Adrián Rodriguez
  
### Alumno:
  - Juan Agustín Schällibaum

### Requerimentos:
  - Ruby 2.6.3 en adelante
  - MariaDB/MySQL
  - bundler


### Pasos para instalar y correr la aplicación:
  1. Clonar el repo de github: `git clone 'https://github.com/ropch4ins/TPI-TTPS-Ruby-2019'`
  2. Posicionarse dentro del repo: `cd TPI-TTPS-Ruby-2019`
  3. Instalar dependencias: `bundle install`
  4. Crear el archivo config/application.yml mediante figaro: `bundle exec figaro install`.
  5. Editar el archivo config/application.yml generado por figaro e incluir la siguiente información:
  ```yml
  database_user: # Usuario para conectarse a la bd
  database_password: # Contraseña del usuario de la bd
  database_address: # Dominio o dirección IP de la bd
  ```
  6. Crear la bd: `rake db:create`.
  7. Crear las tablas de la bd: `rake db:migrate`.
  8. Poblar las tablas con datos de prueba: `rake db:seed`. Los datos agregados serán:
      - 2 usuarios (admin:admin y juan:123456)
      - 20 productos (con código y precio aleatorio)
      - 20 items con estado disponibles a los primeros dos productos creados.
      - 14 condiciones frente al IVA (indicadas por la AFIP)
      - 2 clientes
  9. Correr el servidor web de rails `rails s`


### Ejemplos de interacción con la aplicación mediante curl:

#### POST /sesiones
Inicia sesión con el usuario admin:admin y genera un token de sesión (JWT) válido por 30 minutos:
```sh
curl --request POST \
  --url http://localhost:3000/sesiones \
  --header 'authorization: Bearer ' \
  --header 'content-type: application/json' \
  --data '{
  "u": "admin",
  "p": "admin"
}'
```

#### GET /productos
Retorna todos los productos que se tienen. Se debe reemplazar -TOKEN- por el token JWT obtenido en el paso anterior:
```sh
curl --request GET \
  --url http://localhost:3000/productos?q=all \ 
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/json' \
```

#### POST /reservas
Crea una una reserva de dos unidades del primer producto (con product_id = 1) para el cliente con client_id = 1
```sh
curl --request POST \
  --url http://localhost:3000/reservas 
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/json' \
  --data '{
  "data": {
    "type": "reservation",
    "attributes": {
      "date": "2019-07-05",
      "client_id": 1,
      "user_id": 2,
      "reservation_details": [
        {"product_id": 1, "quantity": 2}
      ]
    }
  }
}'
```

Para enviar requests a los demás endpoints, se debe seguir el mismo formato que el indicado en los ejemplos (respetando el estándar JSON:API). Adicionalmente, los esqueletos de curl necesarios para hacer requests a todos los endpoints, se encuentra el archivo https://github.com/ropch4ins/TPI-TTPS-Ruby-2019/blob/master/comandos.md
