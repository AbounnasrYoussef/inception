# Developer Documentation - Inception

## Environment Setup
1. **Prerequisites:** Ensure Docker and Docker Compose (v2+) are installed.
2. **Configuration:**
   - Create a `.env` file at the root based on the provided template.
   - Create a `secrets/` directory and populate the required files (`db_password.txt`, `db_root_password.txt`, `credentials.txt`).
3. **Data Persistence:** The project relies on bind-mount volumes pointing to `/home/yabounna/data/`. Ensure these directories exist and have the correct permissions.

## Build and Launch
- **Launch:** Run `make up`. This command automates:
  - Directory creation for data persistence.
  - Docker image building.
  - Container orchestration via `docker-compose`.

## Management Commands
- **Logs:** `docker logs <container_name>`
- **Shell access:** `docker exec -it <container_name> /bin/bash`
- **Manage Volumes:** Docker manages persistent data, but physical files are stored on the host machine in `/home/yabounna/data/`.

## Persistence Strategy
Data persistence is achieved using **Bind Mounts**.
- **MariaDB:** Data persists in `/home/yabounna/data/mariadb/`.
- **WordPress:** Files persist in `/home/yabounna/data/wordpress/`.
- **Cleanup:** `make fclean` destroys all containers, images, and volumes. Use with caution as it also performs `rm -rf` on the data directories.
