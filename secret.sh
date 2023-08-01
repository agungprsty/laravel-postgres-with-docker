#!/bin/bash

# Create Docker secrets for the database configuration
echo "Creating Docker secrets for the database configuration..."

# Create the secret for the database name
echo "aselole_db" | docker secret create app_db_name -
echo "Secret for database name (aselole_db) created."

# Create the secret for the database user
echo "aselole" | docker secret create app_db_user -
echo "Secret for database user (aselole) created."

# Create the secret for the database password
echo "password!" | docker secret create app_db_password -
echo "Secret for database password created."

# Create the secret for the database password
echo "password!" | docker secret create app_pgadmin_password -
echo "Secret for pgAdmin password created."

# Finished creating Docker secrets
echo "Docker secrets for the database configuration have been set up."
