#!/bin/sh
DB_HOST=db
DB_PORT=3306
DB_USER=root
DB_PASS=root123

echo "Waiting for MySQL to be ready..."

until mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASS" -e "SELECT 1" &> /dev/null; do
  echo "MySQL is unavailable - sleeping"
  sleep 2
done

echo "MySQL is up - starting app"
exec java -jar /app/app.jar
