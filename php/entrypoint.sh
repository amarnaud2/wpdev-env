#!/bin/bash
set -e

# Si WordPress n’est pas encore installé (wp-config.php manquant)
if [ ! -f /var/www/html/wp-config.php ]; then
  echo "📦 Lancement de l'installation automatique de WordPress..."
  /usr/local/bin/setup.sh
else
  echo "✅ WordPress déjà installé, aucun setup nécessaire."
fi

# Lancer Apache (car on est basé sur wordpress:php8.2-apache)
exec apache2-foreground

