# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    database.sql                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mortega- <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/06 19:26:21 by mortega-          #+#    #+#              #
#    Updated: 2021/03/11 20:39:54 by mortega-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CREATE DATABASE IF NOT EXISTS `wordpress`;
CREATE USER 'mortega'@'localhost' IDENTIFIED BY 'ngnl';
GRANT ALL PRIVILEGES ON *.* TO 'mortega'@'localhost';
FLUSH PRIVILEGES;
