FROM		alpine:3.16.0

RUN		apk update && apk add --no-cache mariadb mariadb-client

COPY		./tools/setup.sh /setup.sh

COPY		./conf/mariadb.conf /etc/my.cnf.d/

RUN		chmod +x /setup.sh /etc/my.cnf.d/mariadb.conf

EXPOSE		3306

ENTRYPOINT	["sh", "setup.sh"]	


