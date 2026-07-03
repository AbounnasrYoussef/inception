FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/sites-available/default
COPY html/ /var/www/website/

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
