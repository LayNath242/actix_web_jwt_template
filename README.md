# Actix-web REST API with JWT

![CI](https://github.com/SakaDream/actix-web-rest-api-with-jwt/workflows/CI/badge.svg)
![Docker CICD](https://github.com/SakaDream/actix-web-rest-api-with-jwt/workflows/Docker%20CICD/badge.svg)

A simple CRUD backend app using Actix-web, Diesel and JWT

## Require

- [Rust Stable](https://rustup.rs)
- [Postgres](https://www.postgresql.org/)

Or using [Docker](https://www.docker.com/)

## How to run

### Manual

- Rename `secret.key.sample` to `secret.key` or create your own key by running `head -c16 /dev/urandom > secret.key` in command line (Linux/UNIX only) and copy to `/src` folder
- Create a database in postgres cli or [pgAdmin](https://www.pgadmin.org/) tool
- Rename `.env.sample` to `.env` and update the database connection string in `DATABASE_URL` key.
- Build with release profile: `cargo build --release`
- Run release binary in command line/terminal.
  - Windows: `target/release/actix-web-rest-api-with-jwt.exe`
  - Linux/UNIX: `target/release/actix-web-rest-api-with-jwt`
- Enjoy! 😄
## APIs

### Address: **`localhost:8000`

### `POST /api/auth/signup`: Signup

```bash
curl -X POST -i 'http://127.0.0.1:8000/api/auth/signup' \
  -H "Content-Type: application/json" \
  --data '{
    "username": "user",
    "email": "user@email.com",
    "password": "4S3cr3tPa55w0rd"
  }'
```

- Request body:

```
{
   "username": string,
   "email": string,
   "password": string       // a raw password
}
```

- Response
  - 200 OK
  ```
  {
     "message": "signup successfully",
     "data": ""
  }
  ```
  - 400 Bad Request
  ```
  {
     "message": "User '{username}' is already registered",
     "data": ""
  }
  ```

### `POST /api/auth/login`: Login

```bash
curl -X POST -H 'Content-Type: application/json' -i 'http://127.0.0.1:8000/api/auth/login'  \
  --data '{"username_or_email":"user",  "password":"4S3cr3tPa55w0rd"}'
```

- Request body:

```
{
   "username_or_email": string,
   "password": string       // a raw password
}
```

- Response
  - 200 OK
  ```
  {
     "message": "login successfully",
     "data": {
       "token": string      // bearer token
     }
  }
  ```
  - 400 Bad Request
  ```
  {
     "message": "wrong username or password, please try again",
     "data": ""
  }
  ```

### `POST /api/auth/logout`: Logout

```bash
curl -X POST -H 'Content-Type: application/json' \
  -H 'Authorization: bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzcyNTc4NzksImV4cCI6MTU3Nzg2MjY3OSwidXNlciI6ImMiLCJsb2dpbl9zZXNzaW9uIjoiYzUxNWE3NTg3NGYzNGVjNGFmNDJmNWE2M2QxMDVjMGYifQ.B9w6FxFdypb5GCRMKXZ9CZWFxQLFjvmPSusMCtcE-Ac' \
  -i 'http://127.0.0.1:8000/api/auth/logout'
```

### `GET /api/address-book`: Get all people information

```bash
curl -X GET -H 'Content-Type: application/json' \
  -H 'Authorization: bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzU4NzM4MjksImV4cCI6MTU3NjQ3ODYyOSwidXNlciI6ImMiLCJsb2dpbl9zZXNzaW9uIjoiZjU5N2M3MTIxZTExNDBhMGE0ZjE0YmQ4N2NjM2Q4MWUifQ.6qppDfRgOw45eExJ7MUEwpcu3AUXXe9_ifj_mp7k22k' \
  -i 'http://127.0.0.1:8000/api/address-book'
```

- Header:
  - Authorization: bearer \<token\>
- Response
  - 200 OK
  ```
  {
     "message": "ok",
     "data": [
        {
          "id": int32,
          "name": string,
          "gender": boolean,      // true for male, false for female
          "age": int32,
          "address": string,
          "phone": string,
          "email": string
        }
     ]
  }
  ```
