#!/bin/bash

mysqldump -h "$DB_SERVER" -u "$DB_USER" -p "$DB_PASSWD" BE_184623 > /seed/prestashop.sql