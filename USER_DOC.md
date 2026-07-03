# User Documentation - Inception

## Overview of Services
This stack provides a fully containerized web hosting environment consisting of:
- **NGINX:** Acts as the entry point, handling incoming HTTPS requests (TLS 1.2/1.3) and acting as a reverse proxy.
- **WordPress:** The CMS platform to manage your content.
- **MariaDB:** The database engine where all posts, users, and settings are stored.

## Project Management
The project is managed via a `Makefile` at the root directory:
- **Start the project:** `make up`
- **Stop the project:** `make down`
- **Restart (Clean & Rebuild):** `make re`

## Accessing the Platform
- **Public Website:** Access your site at `https://yabounna.42.fr`
- **Admin Panel:** Log in to `https://yabounna.42.fr/wp-admin`

## Credentials Management
All passwords and sensitive data are managed via **Docker Secrets**.
- **Location:** `secrets/` directory.
- **Note:** Never share these files. They are excluded from version control via `.gitignore`.

## Monitoring
To check if all services are running correctly:
```bash
docker ps
