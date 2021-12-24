# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mortega- <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/25 16:17:53 by mortega-          #+#    #+#              #
#    Updated: 2021/03/12 13:17:36 by mortega-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

MAINTAINER mortega-

RUN apt-get -y update;\
	apt-get -y upgrade;\
	apt-get -y install apt-utils \
	vim \
	htop \
	wget;

RUN apt-get -y install dstat; \
	apt-get -y install nginx mariadb-server; \
	apt-get -y install php-fpm php-mysql php-xml php-mbstring; 

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz \
	&& tar -xzvf phpMyAdmin-5.1.0-english.tar.gz \
	&& mv phpMyAdmin-5.1.0-english /var/www/html/phpMyAdmin \
	&& chown --recursive www-data:www-data /var/www/html/phpMyAdmin

RUN wget https://es.wordpress.org/latest-es_ES.tar.gz \
	&& tar -xzvf latest-es_ES.tar.gz \
	&& mv wordpress /var/www/html/wordpress

RUN chmod 700 /etc/ssl/private \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
	-keyout /etc/ssl/private/nginx_server.key \
	-out /etc/ssl/private/nginx_server.crt

RUN rm -f /var/www/html/index.nginx-debian.html
RUN rm -rf latest-es_ES.tar.gz phpMyAdmin-5.1.0-english.tar.gz
RUN rm -f /etc/nginx/nginx.conf

COPY srcs/nginx.conf /etc/nginx/
COPY srcs/index.html /var/www/html/
COPY srcs/autoindex_on.sh ./
COPY srcs/autoindex_off.sh ./
COPY srcs/wp-config.php /var/www/html/wordpress/
COPY srcs/database.sql ./
COPY srcs/wordpress.sql ./

CMD service mysql start \
	&& mysql -u root < ./wordpress.sql \
	&& mysql -u root < ./database.sql \
	&& service php7.3-fpm start \
	&& service nginx start \
	&& bash
