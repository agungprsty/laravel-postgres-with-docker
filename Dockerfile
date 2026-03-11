# Step 1: Build & Dependencies
FROM php:8.4-fpm-alpine AS builder

# Set working directory
WORKDIR /var/www/html

# Install build dependencies for PHP extensions
RUN apk add --no-cache \
    $PHPIZE_DEPS \
    libpq-dev \
    libzip-dev \
    zip \
    libpng-dev \
    libxml2-dev \
    icu-dev \
    oniguruma-dev \
    curl-dev

# Install & Configure PHP extensions
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j$(nproc) \
    exif \
    pcntl \
    bcmath \
    ctype \
    zip \
    pdo \
    pdo_pgsql \
    pgsql \
    intl \
    opcache

# Install Composer from the official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# ---------------------------------------------------------

# Step 2: Runtime (Final Image)
FROM php:8.4-fpm-alpine

WORKDIR /var/www/html

# Install only the required runtime libraries (No build tools)
RUN apk add --no-cache \
    libpq \
    libzip \
    libpng \
    libxml2 \
    icu-libs \
    oniguruma \
    nodejs \
    npm \
    bash

# Copy the compiled PHP extension from Step builder
COPY --from=builder /usr/local/lib/php/extensions /usr/local/lib/php/extensions
COPY --from=builder /usr/local/etc/php/conf.d /usr/local/etc/php/conf.d
COPY --from=builder /usr/bin/composer /usr/bin/composer

# Create user non-root
RUN addgroup -g 1000 www && adduser -u 1000 -G www -D www

# Copy app and set permission
COPY --chown=www:www ./src /var/www/html

# Use user non-root
USER www

EXPOSE 9000

CMD ["php-fpm"]
