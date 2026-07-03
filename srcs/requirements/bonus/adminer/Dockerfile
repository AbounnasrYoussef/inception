FROM debian:bookworm

# 1. On installe uniquement PHP (le paquet de base inclut le CLI) et l'extension MySQL
RUN apt-get update && apt-get install -y \
    php \
    php-mysql \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 2. Création du dossier et téléchargement d'Adminer
RUN mkdir -p /var/www/adminer \
    && curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
    -o /var/www/adminer/index.php

# 3. On expose le port 8080 (assure-toi que c'est bien celui du docker-compose.yml)
EXPOSE 8080

# 4. La commande magique pour lancer le serveur PHP intégré
ENTRYPOINT ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer", "/var/www/adminer/index.php"]
