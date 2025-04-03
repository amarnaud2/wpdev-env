# wpdev - Wordpress Development Environment

L'objectif de ce dépôt est de fournir un environnement de développement Wordpress containairisé. 

## Arborescence

```bash
/le-projet/
├── .gitignore
├── .env-local
├── docker-compose.yml
├── php/
│   └── Dockerfile
│   └── entrypoint.sh        
│   └── mailhog.ini  
│   └── php.ini         <-- Fichier de configuration de php personnalisé
│   └── setup.sh        <-- script d'installation WP
│   └── wait-for-it.sh  
├── html/               <-- Dossier WordPress (sera peuplé automatiquement au 1er build)
└── data/
    └── mysql/          <-- Fichiers de la base de données

```

## Comment ça marche ?

- Copier le fichier .env-local en .env
- Lancer ensuite la stack (voir les commandes utiles un peu plus bas)

## php.ini personnalisé

Un fichier php.ini personnalisable se trouve dans le dossier php/. Il inclut :

- Augmentation de la mémoire.
- Temps d’exécution généreux pour les devs.
- Activation des erreurs.
- Paramètres utiles pour WordPress.
- Commentaires pour aider à ajuster facilement les valeurs.

## Commandes utiles 

Ces commandes sont à exécuter depuis le dossier contenant le docker-compose.yml.

```bash
# Démarrer la stack en construisant les images
$> docker-compose up -d --build

# Eteindre la stack
$> docker-compose down

# Supprimer les fichiers de travail
$> sudo rm -rf ./html/* ./data/mysql/* 
```

## Accès 

- [Wordpress : http://localhost:8000](http://localhost:8000)
- [phpMyAdmin : http://localhost:8080](http://localhost:8080)

## Utiliser une autre version de PHP

- Eteindre la stack (si elle est déjà lancée) avec la commande docker-compose down
- Dans le fichier Dockerfile du dossier php, remplacer la ligne FROM wordpress:php8.2-apache par FROM wordpress:php8.1-apache
- Redémarrer avec docker-compose up --build

## Intercepter les mails

- Mailhog est installé dans la stack, accessible à [Mailhog : http://localhost:8025](http://localhost:8025)
- Il faut installer un plugin comme WP Mail Logging puis l'activer ou utiliser un formulaire de contact
- L'envoi vers n'importe quelle adresse email sera visible dans l'interface de Mailhog
