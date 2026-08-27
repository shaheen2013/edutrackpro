FROM debian:stable-slim

WORKDIR /app

# Install dependencies and PHP 8.3 from sury-php
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    git \
    zip \
    unzip \
    libpq-dev \
    libonig-dev \
    libzip-dev \
    supervisor \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    nginx \
    openssh-client \
    && curl -fsSL https://packages.sury.org/php/apt.gpg | tee /usr/share/keyrings/sury-php.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list \
    && apt-get update && apt-get install -y \
    php8.3 \
    php8.3-fpm \
    php8.3-cli \
    php8.3-mysql \
    php8.3-mbstring \
    php8.3-zip \
    php8.3-xml \
    php8.3-curl \
    php8.3-bcmath \
    php8.3-soap \
    php8.3-gd \
    php8.3-intl \
    php8.3-dev \
    php8.3-pdo-mysql \
    php8.3-redis \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js LTS (v20)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get update && apt-get install -y nodejs \
    && node -v \
    && npm -v \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set PHP configurations
RUN echo "upload_max_filesize=20M" >> /etc/php/8.3/fpm/php.ini \
    && echo "post_max_size=30M" >> /etc/php/8.3/fpm/php.ini \
    && echo "memory_limit=512M" >> /etc/php/8.3/fpm/php.ini \
    && echo "date.timezone=UTC" >> /etc/php/8.3/fpm/php.ini

# Environment variables
ENV WEB_DOCUMENT_ROOT=/app/public
ENV APP_ENV=production

# Copy application files
COPY . .

# Copy supervisor configurations
COPY ./supervisor/* /etc/supervisor/conf.d/
RUN chmod +x /etc/supervisor/conf.d/*

# Set up storage directories
RUN mkdir -p storage/framework/sessions storage/framework/views storage/framework/cache \
    && chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Install Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Configure Nginx
RUN rm -f /etc/nginx/sites-enabled/default \
    && ln -sf /etc/nginx/conf.d/default.conf /etc/nginx/sites-enabled/default
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Set up supervisor logs and PHP-FPM run directory
RUN mkdir -p /var/log/supervisor/ /var/run/php/ \
    && chown www-data:www-data /var/log/supervisor/ /var/run/php/ \
    && chmod 775 /var/log/supervisor/ /var/run/php/

# Copy and set up entrypoint
COPY ./scripts/* /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose port
EXPOSE 80

# Entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
