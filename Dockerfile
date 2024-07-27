# Utilisez une image Python de base
FROM python:3.9-slim

# Définissez le répertoire de travail dans le conteneur
WORKDIR /app

# Copiez les fichiers de votre projet dans le conteneur
COPY . /app

# Installez les dépendances du projet
RUN pip install --no-cache-dir -r requirements.txt

# Définissez la commande par défaut pour exécuter votre application
CMD ["python", "app.py"]
