# Utiliser une image alpine légère pour la base
FROM alpine:3.18

# Installer SQLite
RUN apk add --no-cache sqlite

# Définir les variables d'environnement par défaut
ENV SQLITE_DB=${SQLITE_DB:-blogcms}
ENV SQLITE_PASSWORD=${SQLITE_PASSWORD:-!ChangeMe!}
ENV SQLITE_USER=${SQLITE_USER:-app}

# Créer un répertoire pour stocker les données de SQLite
RUN mkdir -p /var/lib/sqlite/data

# Définir le répertoire de travail
WORKDIR /var/lib/sqlite/data

# Exposer le port de la base de données (facultatif, si besoin de se connecter à SQLite depuis l'extérieur)
EXPOSE 5432

# Commande de démarrage (personnaliser si nécessaire)
CMD ["sqlite3", "/var/lib/sqlite/data/${SQLITE_DB:-blogcms}.db"]

# Configuration de santé (healthcheck) similaire à celle utilisée dans compose.yaml
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=5 \
    CMD sqlite3 /var/lib/sqlite/data/${SQLITE_DB:-blogcms}.db "SELECT 1" || exit 1