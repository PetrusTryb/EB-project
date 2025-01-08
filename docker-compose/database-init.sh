#!/bin/bash
if [ "$DB_DONT_TOUCH" != "1" ]; then
echo "DB_DONT_TOUCH is set to 0, initializing database"
mysql -h "$DB_SERVER" -u "$DB_USER" -p"$DB_PASSWD" <<EOF
DROP DATABASE IF EXISTS BE_184623;
CREATE DATABASE BE_184623;
EOF

mysql -h "$DB_SERVER" -u "$DB_USER" -p"$DB_PASSWD" -D BE_184623 <<EOF
SET autocommit=0;
SET unique_checks=0;
SET foreign_key_checks=0;
SOURCE /seed/prestashop.sql;
COMMIT;
SET autocommit=1;
SET unique_checks=1;
SET foreign_key_checks=1;
UPDATE ps_configuration SET value = '$PS_DOMAIN' WHERE name = 'PS_SHOP_DOMAIN' OR name = 'PS_SHOP_DOMAIN_SSL';
UPDATE ps_shop_url SET domain = '$PS_DOMAIN' WHERE id_shop_url = 1;
UPDATE ps_shop_url SET domain_ssl = '$PS_DOMAIN' WHERE id_shop_url = 1;
EOF
else
echo "DB_DONT_TOUCH is set to 1, skipping database initialization"
fi

