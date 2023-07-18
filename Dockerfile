FROM node:20.4-bookworm-slim

WORKDIR /opt/documentation

RUN apt-get update && apt-get install -y --no-install-recommends nginx

COPY . .

RUN mv default /etc/nginx/sites-available/default

RUN npm install && npm run build

EXPOSE 80/tcp

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
