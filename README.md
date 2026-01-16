# gogolf-local

⛳ Welcome to gogolf! gogolf is a toy project I've created to demonstrate understanding of full-stack software development, DevOps and having a *crazy* high handicap. Having said that, I will hopefully get it up-and-running as a useable app at some point.

You're currently looking at the supplementary repository for running the API (and a small PostgreSQL database) on your local machine.

## 🏌️ Related Repositories (More Coming Soon™)


- [gogolf-cli](https://github.com/SamW94/gogolf-cli): CLI tool that interacts with the API
- [gogolf-api](https://github.com/SamW94/gogolf-api): gogolf's backend microservice/API

## 🛺 What's in the box? 

This repository contains a quick-start script that runs the `gogolf-api` container and a PostgreSQL database using `docker compose`. It will also run the goose migrations for you, so the application is ready to go.

## 🚩 How do I run it?

### Pre-requisites

- These instructions are for Linux/Unix/WSL. I'm not writing a Windows guide, and you can't make me.
- You must have the [Go toolchain](https://go.dev/doc/install) installed
- You must have [git](https://git-scm.com/install) installed.
- You must have [Docker](https://www.docker.com/get-started/) installed
- For the easiest experience, you should have [Docker Compose](https://docs.docker.com/compose/install/) installed.
- You must have the [goose CLI tool](https://github.com/pressly/goose?tab=readme-ov-file#install) installed.

1. Clone the `gogolf-api` and `gogolf-local` repos.

    ```
    git clone https://github.com/SamW94/gogolf-api.git
    git clone https://github.com/SamW94/gogolf-local.git
    ```

2. Change directory into the root of the `gogolf-local` repository.

    `cd gogolf-local`

3. Create a `.env` from the `sample-env` file.

    `cp sample-env .env`

4. Edit your `.env` file with your favourite text editor to change the values in there by default to whatever you wish. The `DB_URL` and `GOOSE_DBSTRING` variables must both be the same and be in this format:

    `postgres://<user>:<password>@localhost:5432/<postgres-db-name>?sslmode=disable`

    for example:

    `postgres://user:password@localhost:5432/gogolf?sslmode=disable`

5. Your `.env` file should also contain something like this to ensure the API container can communicate with the database (`localhost` will not work as the DB URL if you're using docker compose): 

    `DB_URL_DOCKER="postgres://<user>:<password>@gogolf-postgres:5432/gogolf?sslmode=disable"`

6. Ensure your Docker engine is running.

*The API container by default uses the latest versioned image, but you can modify it to use an image you're working on, or any other version you want by modifying the `image` value:.*

    ```
    api:
        image: <gogolf-api image>
        container_name: gogolf-api
        restart: unless-stopped
        environment:
        INTERNAL_PORT: 8080
        DB_URL: ${DB_URL_DOCKER}
        ports: 
        - "8080:8080"
    ```

7. Run `setup-db.sh` to start the API and database containers, and run the goose migration.

    ```
    chmod +x setup-db.sh
    ./setup-db.sh
    ```

8. The API is serving traffic on `http://localhost:8080` - test it out using Postman or curl!