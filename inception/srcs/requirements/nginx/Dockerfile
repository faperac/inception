FROM		alpine:3.16.0

RUN		apk update && apk upgrade && apk add --no-cache \
		nginx \
		openssl

RUN		mkdir -p /run/nginx /etc/nginx/ssl /var/www/html

RUN		chmod -R 777 /var

RUN		openssl req -x509 -nodes -newkey rsa:2048 \
		-keyout /etc/nginx/ssl/inception.key \
		-out /etc/nginx/ssl/inception.crt \
		-subj "/C=FR/ST=Nice/L=Nice/O=42Nice/OU=fabperei/CN=inception"

COPY		./conf/nginx.conf /etc/nginx/

EXPOSE		443

ENTRYPOINT	["nginx", "-g", "daemon off;"]
