# gogolf-local

⛳ Welcome to gogolf! gogolf is a toy project I've created to demonstrate understanding of full-stack software development, DevOps and having a *crazy* high handicap. Having said that, I will hopefully get it up-and-running as a useable app at some point.

You're currently looking at the supplementary repository for running the API (and a small PostgreSQL database) on your local machine.

## 🏌️ Related Repositories (More Coming Soon™)

- [gogolf-api](https://github.com/SamW94/gogolf-api): gogolf's backend microservice/API
- [gogolf-web](https://github.com/SamW94/gogolf-web): gogolf's frontend microservice. 
- [gogolf-cli](https://github.com/SamW94/gogolf-cli): CLI tool that interacts with the API


## 🛺 What's in the box? 

This repository contains a quick-start script that runs the `gogolf-api` container, the `gogolf-web` container and a PostgreSQL database using `docker compose`. It will also run the goose migrations for you, so the application is ready to go.

## 🚩 How do I run it?

### Pre-requisites

- These instructions are for Linux/Unix/WSL. I'm not writing a Windows guide, and you can't make me.
- You must have [git](https://git-scm.com/install) installed.
- You must have [Docker](https://www.docker.com/get-started/) installed
- For the easiest experience, you should have [Docker Compose](https://docs.docker.com/compose/install/) installed.

1. Clone the `gogolf-api` and `gogolf-local` repos.

    ```
    git clone https://github.com/SamW94/gogolf-api.git
    git clone https://github.com/SamW94/gogolf-local.git
    ```

2. Change directory into the root of the `gogolf-local` repository.

    `cd gogolf-local`

3. Create a `.env` from the `sample-env` file. **DO NOT COMMIT CHANGES TO THE `sample-env` FILE.**

    `cp sample-env .env`

4. Your `.env` file should also contain something like this to ensure the API container can communicate with the database (`localhost` will not work as the DB URL if you're using docker compose): 

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

7. Run `docker compose up -d` to start the API, web and database containers, and run the goose migration.

8. The API is serving traffic on `http://localhost:8080` - test it out using Postman, curl or the frontend at `http://localhost:3000`!