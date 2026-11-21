#!/bin/bash
# helper: generate .env, cert and WP admin credentials (not committed)
cd "$(dirname "$0")"
gen(){ tr -dc 'A-Za-z0-9' </dev/urandom | head -c 20; }
[ -f .env ] || cat > .env <<E
MYSQL_DATABASE=wordpress_melko
MYSQL_ROOT_PASSWORD=$(gen)
MYSQL_USER=melko_wp
MYSQL_PASSWORD=$(gen)
E
[ -f wp-admin.txt ] || printf 'WordPress admin\nlogin: viktoriia-admin\npassword: %s\nemail: admin@viktoriia-melko.local\n' "$(gen)" > wp-admin.txt
