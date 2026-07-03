*This project has been created as part of the 42 curriculum by yabounna.*

# Inception

## Description

**Inception** is a system administration project from the 42 curriculum that introduces containerization using Docker.

The objective of the project is to build a secure, scalable, and modular web infrastructure composed of multiple isolated services. Every service runs inside its own Docker container and is orchestrated using Docker Compose.

Unlike standard Docker projects, all images must be built manually from custom Dockerfiles based on the penultimate stable version of Debian. Using pre-built images (except Debian or Alpine as a base image) is not allowed.

The infrastructure includes:

* Nginx configured with TLS (HTTPS only)
* WordPress running with PHP-FPM
* MariaDB database
* Docker volumes for persistent data
* A dedicated Docker network for communication between containers

This project aims to understand containerization, networking, storage, security, and service orchestration.

---

# Project Architecture

```
                 Internet
                     │
                  HTTPS 443
                     │
                +-----------+
                |   Nginx   |
                +-----------+
                     │
          Docker Bridge Network
             ┌─────────┴─────────┐
             │                   │
      +-------------+     +-------------+
      | WordPress   | <-> |   MariaDB   |
      |   PHP-FPM   |     |  Database   |
      +-------------+     +-------------+

      Persistent Docker Volumes
        ├── WordPress files
        └── MariaDB data
```

---

# Project Components

## Nginx

Nginx is the only service exposed to the outside world.

Its responsibilities are:

* handling HTTPS connections;
* terminating TLS;
* forwarding PHP requests to PHP-FPM;
* serving static files.

---

## WordPress

WordPress provides the web application.

PHP-FPM executes PHP scripts and communicates with Nginx through FastCGI.

---

## MariaDB

MariaDB stores:

* users;
* posts;
* comments;
* website configuration.

Database files are stored inside a Docker Volume to preserve data.

---

## Docker Network

All containers communicate through a dedicated Docker bridge network.

Only Nginx exposes a port to the host machine.

MariaDB and WordPress remain isolated from external access.

---

## Docker Volumes

Persistent storage is provided using Docker Volumes.

The following data survives container recreation:

* WordPress website files
* MariaDB database

---

# Design Choices

Several design decisions were made during the implementation:

* Debian 12 was selected as the base operating system because of its stability and long-term support.
* Each service runs inside its own container to respect the principle of separation of concerns.
* Docker Compose orchestrates the complete infrastructure.
* Nginx is the only public entry point to reduce the attack surface.
* TLS is enforced so every connection is encrypted.
* Docker Volumes are used to preserve persistent data.
* A dedicated bridge network isolates internal communications.

---

# Instructions

## Prerequisites

Install:

* Docker
* Docker Compose
* Make

---

## Configure the local domain

Edit `/etc/hosts`

```text
127.0.0.1 yabounna.42.fr
```

---

## Create data directories

```bash
mkdir -p /home/yabounna/data/mariadb
mkdir -p /home/yabounna/data/wordpress
```

---

## Configure environment variables

Create a `.env` file containing the required variables.

Example:

```env
DOMAIN_NAME=yabounna.42.fr

MYSQL_DATABASE=wordpress
MYSQL_USER=user
MYSQL_PASSWORD=password
MYSQL_ROOT_PASSWORD=rootpassword

WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=password
WP_ADMIN_EMAIL=admin@example.com

WP_USER=user
WP_USER_PASSWORD=password
WP_USER_EMAIL=user@example.com
```

---

## Build the project

```bash
make
```

or

```bash
docker compose up --build
```

---

## Stop the project

```bash
make down
```

---

## Remove everything

```bash
make fclean
```

---

# Usage

Once the infrastructure is running, open:

```
https://yabounna.42.fr
```

The website should be accessible using HTTPS.

---

# Project Structure

```
.
├── Makefile
├── docker-compose.yml
├── secrets/
├── srcs/
│   ├── requirements/
│   │   ├── mariadb/
│   │   ├── nginx/
│   │   └── wordpress/
│   └── .env
└── README.md
```

---

# Docker Concepts

## Virtual Machines vs Docker

| Virtual Machines                     | Docker                  |
| ------------------------------------ | ----------------------- |
| Includes a complete operating system | Shares the host kernel  |
| High resource usage                  | Lightweight             |
| Slow startup                         | Fast startup            |
| Strong hardware isolation            | Process-level isolation |
| Larger disk footprint                | Small image size        |

Docker is ideal for deploying multiple lightweight services efficiently, while Virtual Machines are more suitable when complete operating system isolation is required.

---

## Secrets vs Environment Variables

Environment variables are commonly used for application configuration but are not intended for storing confidential information because they can be exposed by processes or logs.

Docker Secrets are specifically designed for sensitive data such as passwords, API keys, and certificates. They are mounted securely inside containers and are not stored directly as environment variables.

For this project, environment variables are sufficient because Docker Swarm is not used, but Docker Secrets would be the preferred solution in a production environment.

---

## Docker Network vs Host Network

### Docker Bridge Network

* isolates containers;
* allows internal communication;
* improves security;
* supports DNS-based service discovery.

### Host Network

* shares the host networking stack;
* offers higher performance;
* removes network isolation;
* increases security risks.

A bridge network is therefore the most appropriate choice for this project.

---

## Docker Volumes vs Bind Mounts

### Docker Volumes

* managed by Docker;
* portable;
* persistent;
* recommended for databases.

### Bind Mounts

* map an existing host directory;
* useful during development;
* tightly coupled to the host filesystem.

Docker Volumes were chosen because they provide better persistence and portability.

---

# Security

The infrastructure follows several security principles:

* HTTPS only (TLS 1.2 / TLS 1.3)
* Isolated containers
* Dedicated Docker network
* No unnecessary exposed ports
* Persistent data stored in Docker Volumes
* Separate database and application services

---

# Resources

The following references were used throughout the project:

* Docker Official Documentation
* Docker Compose Documentation
* Nginx Official Documentation
* MariaDB Official Documentation
* WordPress Developer Documentation
* Debian Documentation
* OpenSSL Documentation
* PHP-FPM Documentation

---

# AI Usage

Artificial Intelligence (ChatGPT) was used as a learning assistant during this project.

It was used to:

* better understand Docker concepts;
* clarify Docker networking and volumes;
* troubleshoot configuration issues;
* review shell scripts;
* improve documentation and technical explanations.

All Dockerfiles, configuration files, architecture decisions, shell scripts, and the overall implementation were manually designed, tested, and validated.

---

# Learning Outcomes

This project helped develop knowledge in:

* Docker
* Docker Compose
* Linux system administration
* Networking
* HTTPS and TLS
* Reverse proxy configuration
* Persistent storage
* Service orchestration
* Container security
* Infrastructure design
