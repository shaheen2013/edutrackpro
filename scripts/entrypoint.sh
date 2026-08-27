#!/bin/bash
set -Eeuo pipefail

cd /app
composer install --no-interaction --optimize-autoloader
npm install
npm run prod
php artisan storage:link || true

# Ensure .env exists and has an application key
if [ ! -f .env ] && [ -f .env.example ]; then
    cp .env.example .env
fi

if [ -f .env ]; then
    if ! grep -q "^APP_KEY=.\+" .env; then
        php artisan key:generate --force
    fi
fi

php artisan migrate --force

# Handle ENV_FILE configuration safely
if [ -n "${ENV_FILE:-}" ] && [ -f "$ENV_FILE" ]; then
    chown www-data:www-data "$ENV_FILE"
    chmod 640 "$ENV_FILE"
elif [ -f .env ]; then
    chown www-data:www-data .env
    chmod 640 .env
fi

chmod -R 775 storage bootstrap/cache public
chown -R www-data:www-data storage bootstrap/cache
find public -maxdepth 1 ! -name 'storage' -exec chown www-data:www-data {} \; 2>/dev/null || true

# Start FPM and Supervisor services
service php8.3-fpm start || /etc/init.d/php8.3-fpm start || /usr/sbin/php-fpm8.3 -D
service supervisor start || /etc/init.d/supervisor start

supervisorctl reread
supervisorctl update
supervisorctl start all

exec nginx -g "daemon off;"
