# Use the official PHP 8.2 FPM Alpine image
FROM php:8.3-fpm-alpine

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    npm

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip exif pcntl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Copy custom PHP configuration file
COPY docker/php/php.ini /usr/local/etc/php/php.ini

# Copy existing application directory contents
COPY ./src /var/www

# Install Laravel dependencies
# RUN composer install && \
#     npm install && \
#     npm run dev
    
RUN chmod 777 -R /var/www/

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
