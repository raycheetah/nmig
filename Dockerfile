# syntax=docker/dockerfile:1

ARG NODE_VERSION=20

FROM node:${NODE_VERSION}-alpine

WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Define build arguments
ARG pgsql_host
ARG pgsql_port
ARG pgsql_db
ARG pgsql_user
ARG pgsql_password
ARG mysql_host
ARG mysql_port
ARG mysql_db
ARG mysql_user
ARG mysql_password

# Set environment variables
ENV POSTGRES_HOST=${pgsql_host}
ENV POSTGRES_PORT=${pgsql_port}
ENV POSTGRES_DATABASE=${pgsql_db}
ENV POSTGRES_USER=${pgsql_user}
ENV POSTGRES_PASSWORD=${pgsql_password}
ENV MYSQL_HOST=${mysql_host}
ENV MYSQL_PORT=${mysql_port}
ENV MYSQL_DATABASE=${mysql_db}
ENV MYSQL_USER=${mysql_user}
ENV MYSQL_PASSWORD=${mysql_password}

# Copy source files into the image.
COPY . .

# Install dependencies, and build
RUN npm install && npm run build

# Expose default PostgreSQL and MySQL ports
EXPOSE ${pgsql_port}
EXPOSE ${mysql_port}

# Command to run the application
CMD ["npm", "start"]
