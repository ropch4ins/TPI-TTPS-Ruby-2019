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
  
### Correcciones de la segunda entrega:
  - Controlador de estadísticas añadido, para obtener usuarios con mayor cantidad de ventas y ventas de mayor monto total.
  - Las columnas de la base en relaciones opcionales pueden ser nulas.
  - Se almacena el precio de venta en el modelo ItemSell.
  - Se utilizan transacciones de la base para operaciones donde se involucran distintas tablas
  - Las validaciones de datos se realizan en el modelo
  - Implementado el parámetro include para los compound documents de JSON API.
  - Todos los modelos y controladores terminados.
  
### Seguridad:

#### Autenticación:
  - Las contraseñas se almacenan en la base en bcrypt, la cuál es una función de hash robusta basada en Blowfish. El tiempo de computación de éste hash es relativamente alto, lo que dificulta ataques de fuerza bruta. Además bcrypt añade un salt random al hashear los passwords, lo que hace más dificil otro tipo de ataques de password cracking, como por ejemplo el ataque que emplea tablas rainbow.
  - Política de contraseñas robusta: para crear un nuevo usuario, su password debe contener un mínimo de 8 caracteres, entre los cuales debe haber por lo menos un dígito numérico, un caracter en minúscula, otro en mayúscula, y un caracter especial.
  - Los usuarios que se crean deben ser únicos en la base de datos.
  
#### Gestión de sesiones:
  - Para las sesiones se emplea JWT (JSON Web Token), usando el cifrado HMAC-SHA256. En el payload del token se guarda el id del usuario actual, y una fecha de expiración de 30 minutos. Luego de 30 minutos, el usuario se debe autenticar nuevamente para regenerar el token.
  - En heroku la clave secreta para firmar el token es de 128 caracteres de longitud.
  - La app incluye un mecanismo para prevenir que atacantes que hayan conseguido acceso a la clave secreta no puedan generar tokens arbitrarios (por ejemplo, modificando el user_id o la fecha de expiración del token). Si bien la clave secreta al ser de 128 caracteres de longitud es imposible de obtener por fuerza bruta, si el atacante consiguió acceso a la clave mediante algún otro método, podría generar un token con user_id y fecha de expiración arbitrarios firmándolos con dicha clave. Para impedir ésto, la aplicación además de corroborar la validez del token (de su firma), comprueba que el token haya sido generado por la aplicación y no exteriormente. Ésto último se lleva a cabo mediante dos pasos:
    1 - Almacacenando el token en la base de datos en el momento en el que cada usuario se autentica. El token se almacena en la base de datos en la columna temp_token del modelo Usuarios, por cada usuario autenticado. Se almacena el SHA-256 del token para evitar robos de sesion en caso de que el atacante tenga acceso a la base de datos.
    2 - Cada vez que el usuario quiere acceder a un endpoint privado, se comprueba que el SHA-256 del token enviado en el header sea el mismo al almacenado en la base. Si se cumple ésto, significa que el token además de ser válido (contar con una firma válida), fue generado por la aplicación y no desde el exterior.
  - Para terminar de hacer que el modelo de gestión de sesiones sea robusto, se añade el campo "key" en el payload del JWT, el cuál es un número random en hexadecimal de 32 dígitos que se genera previamente a la generación del token. Para qué sirve? En el peor de los casos, si algún atacante consiguió la clave secreta para firmar los tokens, si bien no puede generar tokens arbitrarios ya que se dispone de la medida de seguridad anterior, sabiéndo que los tokens expiran en 30 minutos, podría intentar generar un token con algún user_id y bruteforceando los últimos valores de la fecha de expiración. Luego de generarlos y firmarlos con la clave secreta, con suerte se podría generar un token similar al almacenado en la base de datos (generado por la aplicación), el cuál tenga el mismo user_id, misma fecha de expiración al almacenado en la base, y por supuesto, firmado con la clave secreta válida. Si el atacante lograra hacer ésto, podría suplantar una sesión. El número random del campo "key" que se añade sirve para prevenir ésto último. Ya que para generar el mismo token no solo debería sacar por fuerza bruta el timestamp correcto para algún user_id, sino que también tendría que conseguir el valor de "key" por fuerza bruta, lo cuál se hace inviable.
  
#### Control de acceso:
  - El diseño de la aplicación no incluye distintos tipos de roles para los usuarios, solo distingue entre endpoints privados (que requieren autenticación), y endpoints que no requieren autenticación. Los únicos endpoints que no requieren autenticación son el endpoint para autenticarse y el endpoint para crear usuarios nuevos. Para acceder a los demás endpoints se requiere estar autenticado.
    

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
  --url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/sesiones \
  --header 'accept: application/vnd.api+json' \
  --header 'authorization: Bearer ' \
  --header 'content-type: application/vnd.api+json' \
  --data '{
  "data": {
    "type": "authentication",
    "attributes": {
	"u": "admin",
	"p": "admin"
    }
  }
}'
```

#### POST /usuarios
```
curl --request POST \
  --url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/usuarios \
  --header 'accept: application/vnd.api+json' \
  --header 'content-type: application/vnd.api+json' \
  --data '{
  "data": {
    "type": "user",
    "attributes": {
			"username": "miguel",
			"password": "sdgc#123AB"			
		}
  }
}'
```

#### GET /productos
Retorna todos los productos que se tienen. Se debe reemplazar -TOKEN- por el token JWT obtenido en el paso anterior:
```sh
curl --request GET \
  --url 'https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/productos?q=all' \
  --header 'accept: application/vnd.api+json' \
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/vnd.api+json'
```

#### GET /productos/:codigo
```
curl --request GET \
  --url 'https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/productos/IIK520306' \
  --header 'accept: application/vnd.api+json' \
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/vnd.api+json'
```

#### GET /productos/:codigo/items
```
curl --request GET \
  --url 'https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/productos/IIK520306/items' \
  --header 'accept: application/vnd.api+json' \
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/vnd.api+json'
```

#### POST /productos/:codigo/items
```
curl --request POST \
  --url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/productos/AHP863512/items \
  --header 'accept: application/vnd.api+json' \
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/vnd.api+json' \
  --data '{
	"data": {
		"attributes": {
			"quantity": 3
		}
	}
}'
```

#### GET /reservas
```
curl --request GET \
  --url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/reservas \
  --header 'accept: application/vnd.api+json' \
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/vnd.api+json'
```

#### GET /reservas/:id
```
curl --request GET \
  --url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/reservas/2 \
  --header 'accept: application/vnd.api+json' \
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/vnd.api+json'
 ```

#### POST /reservas
Crea una una reserva de dos unidades del primer producto (con product_id = 1) para el cliente con client_id = 1
```
curl --request POST \
  --url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/reservas \
  --header 'accept: application/vnd.api+json' \
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/vnd.api+json' \
  --data '{
	"data": {
		"type": "reservation",
		"attributes": {
			"date": "2020-02-05",
			"client_id": 1,
			"user_id": 1,
			"reservation_details": [
				{
					"product_id": 1,
					"quantity": 3
				}
			]
		}
	}
}'
```

#### PUT /reservas/:id/vender
```
curl --request PUT \
  --url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/reservas/3/vender \
  --header 'accept: application/vnd.api+json' \
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/vnd.api+json'
```

#### DELETE /reservas/:id
```
curl --request DELETE \
  --url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/reservas/10 \
  --header 'accept: application/vnd.api+json' \
  --header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/vnd.api+json'
```

#### GET /ventas
```
curl --request GET \
    --url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/ventas \
    --header 'accept: application/vnd.api+json' \
    --header 'authorization: Bearer -TOKEN-' \
    --header 'content-type: application/vnd.api+json'
```

#### GET /ventas/:id
```
curl --request GET \
--url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/ventas/2 \
--header 'accept: application/vnd.api+json' \
--header 'authorization: Bearer -TOKEN-' \
  --header 'content-type: application/vnd.api+json'
```

#### POST /ventas
```
curl --request POST \
--url https://tpi-ttps-ruby-2019-schallibaum.herokuapp.com/ventas \
--header 'accept: application/vnd.api+json' \
--header 'authorization: Bearer -TOKEN-' \
--header 'content-type: application/vnd.api+json' \
--data '{
"data": {
  "type": "sell",
  "attributes": {
      "date": "2020-02-02",
      "client_id": 1,
      "user_id": 3,
      "sell_details": [
      {
          "product_id": 2,
          "quantity": 2
      }
      ]
  }
}
}'
```

Para enviar requests a los demás endpoints, se debe seguir el mismo formato que el indicado en los ejemplos (respetando el estándar JSON:API). Adicionalmente, los esqueletos de curl necesarios para hacer requests a todos los endpoints, se encuentra el archivo https://github.com/ropch4ins/TPI-TTPS-Ruby-2019/blob/master/comandos.md
