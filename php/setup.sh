#!/bin/bash
set -e

cd /var/www/html

# Télécharger WordPress si nécessaire
if [ ! -f wp-load.php ]; then
  echo "⬇️ Téléchargement de WordPress..."
  wp core download --allow-root
fi

# Attendre que MySQL soit vraiment prêt
echo "⏳ Attente de disponibilité du service MySQL..."
echo "⏳ Attente de disponibilité du service MySQL..."
wait-for-it.sh "${WORDPRESS_DB_HOST}" 3306
echo "✅ MySQL est prêt !"

# Créer wp-config.php si absent
if [ ! -f wp-config.php ]; then
  echo "⚙️ Génération du fichier de configuration..."
  wp config create \
    --dbname="${WORDPRESS_DB_NAME}" \
    --dbuser="${WORDPRESS_DB_USER}" \
    --dbpass="${WORDPRESS_DB_PASSWORD}" \
    --dbhost="${WORDPRESS_DB_HOST}" \
    --skip-check \
    --allow-root
fi

# Installer WordPress si non installé
if ! wp core is-installed --allow-root; then
  echo "🚀 Installation de WordPress..."

  wp core install \
    --url="${WORDPRESS_URL}" \
    --title="${WORDPRESS_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
    --skip-email \
    --allow-root

  echo "✅ WordPress installé avec succès !"
else
  echo "✅ WordPress est déjà installé."
fi

# Lancer le service Apache2
exec docker-entrypoint.sh apache2-foreground

