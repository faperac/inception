FROM	alpine:3.16.0

RUN	apk add --no-cache \
	php8 \
	php8-fpm \
	php8-mysqli \
	php8-phar \
	php8-iconv \
	wget	\
	mariadb \
	mariadb-client

WORKDIR	/var/www

RUN	wget https://wordpress.org/latest.tar.gz

RUN	tar -xzf latest.tar.gz \
	&& rm latest.tar.gz

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /dev/null 2>&1 \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN	mkdir -p /var/www/html/

RUN	cp -r wordpress/* .

RUN	rm -r wordpress

COPY	./conf/www.conf /etc/php8/php-fpm.d/www.conf

COPY	./tools/setup.sh /tmp

RUN	chmod +x /tmp/setup.sh

EXPOSE	9000

# CMD	["/bin/sh" , "/tmp/setup.sh"]
CMD	["top"]

