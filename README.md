# README

## Api endpoints

### Auth user

Request: `POST /api/user_token`

Payload:

```json
{
  "auth": {
    "email": "testing@example.org",
    "password": "123456789"
  }
}
```

Response:

Headers:

 - status code: 201 (created)

```json
{
    "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MjQ3MDAxNzIsInN1YiI6MX0.pMeyib_dIcFFI5XHhkmcGmQcz-Yz30mEJwO_qbzEv7U"
}
```

En caso de que el usuario no exista o la contraseña sea incorrecta, devolverá un (404 - Not found) como código de respuesta en el header

### Password reset

Request: `POST /api/password_reset`

Payload:
```json
{
  "password_reset": {
    "email": "user@example.org"
  }
}
```

Response:

Headers:

 - status code: 201 (created)

```json
{
  "ok": true
}
```

En caso de que el usuario no exista, devolverá un (404 - Not found) como código de respuesta en el header


### Get User Details

Request: `GET /api/user`

Headers: `Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MjQ3MDAxNzIsInN1YiI6MX0.pMeyib_dIcFFI5XHhkmcGmQcz-Yz30mEJwO_qbzEv7U`

Response:

Headers:

 - status code: 200 (ok)

```json
{
  "user": {
    "name": "Gustavo Petro",
    "email": "user@example.org",
    "coordinator": true,
    "post": {
      "id": 1,
      "name": "Nombre del puesto",
      "department": {
        "id": 1,
        "name": "Bogotá DC"
      },
      "municipality": {
        "id": 1,
        "name": "Bogotá"
      },
      "zone": {
        "id": 1,
        "name": "Zona 01"
      },
      "tables": [
        {"id": 1, "name": "Mesa 1"},
        {"id": 2, "name": "Mesa 2"},
        {"id": 3, "name": "Mesa 3"}
      ]
    }
  }
}
```

En caso de que el usuario no esté autenticado, devolverá un (401 - Unauthorized) como código de respuesta en el header


### Get News

Request: `GET /api/news`

Headers: `Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MjQ3MDAxNzIsInN1YiI6MX0.pMeyib_dIcFFI5XHhkmcGmQcz-Yz30mEJwO_qbzEv7U`

Response:

Headers:

 - status code: 200 (ok)

```json
{
    "news": [
        {
            "title": "Prueba de noticia 2",
            "content": "Este es el contenido de un mensaje de ejemplo. Hasta 250 caracteres.",
            "updated_at": "2018-04-24T21:26:12.892Z"
        },
        {
            "title": "Prueba de noticia",
            "content": "Este es el contenido de un mensaje de ejemplo. Hasta 250 caracteres.",
            "updated_at": "2018-04-24T21:26:12.888Z"
        }
    ]
}
```

En caso de que el usuario no esté autenticado, devolverá un (401 - Unauthorized) como código de respuesta en el header


### Upload table results

Request: `POST /api/results`

Headers:
 - `Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MjQ3MDAxNzIsInN1YiI6MX0.pMeyib_dIcFFI5XHhkmcGmQcz-Yz30mEJwO_qbzEv7U`

Payload:

```json
{
  "result": {
    "table": 1,
    "votes": {
      "total_mesa": 300,
      "petro": 150,
      "promotores": 10,
      "duque": 10,
      "la_calle": 10,
      "trujillo": 10,
      "fajardo": 10,
      "morales": 10,
      "piedad": 10,
      "vargas": 10,
      "votos_validos": 300,
      "votos_blancos": 10,
      "votos_nulos": 10,
      "votos_no_marcados": 10,
      "total": 300
    },
    "e14_url": "https://uploaded_image"
  }
}
```
Response:

Headers:

 - status code: 201 (created)

```json
{
 "ok": true,
 "result": {
   "table": 1,
   "votes": {
     "total_mesa": 300,
     "petro": 150,
     "promotores": 10,
     "duque": 10,
     "la_calle": 10,
     "trujillo": 10,
     "fajardo": 10,
     "morales": 10,
     "piedad": 10,
     "vargas": 10,
     "votos_validos": 300,
     "votos_blancos": 10,
     "votos_nulos": 10,
     "votos_no_marcados": 10,
     "total": 300
   },
   "e14_url": "https://uploaded_image"
 }
}
```

En caso de que el usuario no esté autenticado o intente modificar una mesa a la que no está autorizado, devolverá un (401 - Unauthorized) como código de respuesta en el header

### Reportar incidencia

Se guardará la incidencia correspondiente en el puesto asignado al testigo.

Request: `POST /api/issue`

Headers:
 - `Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MjQ3MDAxNzIsInN1YiI6MX0.pMeyib_dIcFFI5XHhkmcGmQcz-Yz30mEJwO_qbzEv7U`

Payload:

```json
{
  "issue": {
    "id": 1
  }
}
```

Headers:

 - status code: 201 (created)

```json
{
  "ok": true,
  "issue": {
    "name": "Jurados de Votación",
    "id": 1
  }
}
```

En caso de que el usuario no esté autenticado, devolverá un (401 - Unauthorized) como código de respuesta en el header
