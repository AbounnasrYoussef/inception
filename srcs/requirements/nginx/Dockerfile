FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=MA/L=Khouribga/O=1337/CN=yabounna.42.fr"

COPY conf/nginx.conf /etc/nginx/sites-available/default

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
