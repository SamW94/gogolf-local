#!/bin/bash

docker compose up -d
cd ../gogolf-api/sql/schema
goose up -env ../../../gogolf-local/.env