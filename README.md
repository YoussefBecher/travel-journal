# Travel Journal

Application mobile Flutter pour explorer des destinations de voyage, ajouter ses préférées en favoris (♥) et les retrouver dans l'écran **My Trips**. Projet réalisé dans le cadre du cours Flutter/Dart (Session 4 : gestion d'état partagé avec **Provider**).

## Fonctionnalités

- **Explorer** : liste de destinations affichées sous forme de cartes (image, nom, description).
- **Favoris** : bouton ♥ sur chaque carte pour ajouter ou retirer une destination de ses favoris.
- **My Trips** : écran qui regroupe toutes les destinations mises en favoris, avec un bouton pour vider la liste.
- **État partagé** : les favoris sont synchronisés entre les écrans grâce à Provider.

## Technologies

- [Flutter](https://flutter.dev) et Dart
- [Provider](https://pub.dev/packages/provider) pour la gestion d'état (`ChangeNotifier`)
- Android Studio comme environnement de développement

## Structure du projet

```
lib/
├── main.dart                      # Point d'entrée, configuration de Provider et de la navigation
├── models/
│   └── destination.dart           # Modèle Destination
├── providers/
│   └── favorites_provider.dart    # FavoritesProvider : ajout, retrait, vidage des favoris
├── screens/
│   ├── explore_screen.dart        # Écran Explorer
│   └── my_trips_screen.dart       # Écran My Trips (favoris)
└── widgets/
    └── destination_card.dart      # Carte d'une destination avec bouton ♥
```

## Installation et lancement

Prérequis : [Flutter SDK](https://docs.flutter.dev/get-started/install) installé, et un émulateur Android ou un téléphone branché en mode développeur.

```bash
# 1. Cloner le dépôt
git clone https://github.com/YoussefBecher/travel-journal.git
cd travel-journal

# 2. Installer les dépendances
flutter pub get

# 3. Lancer l'application
flutter run
```

Pour vérifier que l'environnement est prêt : `flutter doctor`.

## Auteur

**Youssef Becher**, étudiant en informatique à Polytech INTL (Tunis).
GitHub : [@YoussefBecher](https://github.com/YoussefBecher)
