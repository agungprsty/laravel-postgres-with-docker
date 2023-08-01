# Laravel using PostgreSQL in Docker

<p align="center">
    <img src="./docker/images/laravel+docker.png" alt="docker+laravel">
</p>

## Introduction

Build a simple laravel application development environment with docker compose.


## Requirement

- Docker ^19.*


## Installation

1. Git clone & move to working directory
2. Settings your credentials docker compose using [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/)

- Create credentials for DB Name

    ```bash
    $ echo "<your_db_name>" | docker secret create app_db_name -
    ```
- Create credentials for DB User

    ```bash
    $ echo "<your_db_user>" | docker secret create app_db_user -
    ```
- Create credentials for DB Password

    ```bash
    $ echo "<your_db_password>" | docker secret create app_db_password -
    ```
### *Optional credentials*
If you want to use pgAdmin management add this credentials:

- Create credentials for pgAdmin Password

    ```bash
    $ echo "<your_pgadmin_password>" | docker secret create app_pgadmin_password -
    ```

**Uncomment** in top level secret for pgAdmin in file docker-compose.yml to:
```bash
  app_pgadmin_password:
    external: true
```

1. Execute the following command for create application

```bash
$ make create-project
```

4. set src/.env variable :
```
DB_CONNECTION=pgsql
DB_HOST=postgres
DB_PORT=5432
DB_DATABASE=<your_database>
DB_USERNAME=<your_username>
DB_PASSWORD=<your_password>
```

5. show application in [http://localhost:85](http://localhost:85)
6. show adminer in [http://localhost:8080](http://localhost:8080)
7. list execute command in [Makefile](Makefile).

## Container details :
- ``app`` use image:
  - [php](https://hub.docker.com/_/php):8.2-fpm
  - [composer](https://hub.docker.com/_/composer):2.3
  - [npm](https://deb.nodesource.com/setup_lts.x):latest
- ``web`` use image:
  - [nginx](https://hub.docker.com/_/nginx):stable-alpine
- ``db`` use image:
  - [postgres](https://hub.docker.com/_/postgres):15
- ``adminer`` use image:
  - [adminer](https://hub.docker.com/_/adminer):latest
*Optional*
- ``pgadmin`` use image:
  - [pgadmin](https://hub.docker.com/_/pgadmin):latest
