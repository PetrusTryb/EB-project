#!/bin/bash

mysql -h "$DB_SERVER" -u "$DB_USER" -p"$DB_PASSWD" <<EOF
DROP DATABASE IF EXISTS BE_184623;
CREATE DATABASE BE_184623;
EOF

mysql -h "$DB_SERVER" -u "$DB_USER" -p"$DB_PASSWD" -D BE_184623 < /seed/prestashop.sql