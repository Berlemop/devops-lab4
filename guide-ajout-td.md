---
title: "Guide : Ajouter un nouveau TD"
---

# Comment ajouter votre TD sur le site

Ce guide explique comment ajouter un nouveau compte-rendu de TD (Travaux Dirigés) sur ce site.

## Prérequis (Première fois uniquement)

Si vous n'avez jamais utilisé ce projet sur votre machine, vous devez d'abord vous authentifier pour pouvoir déployer :

1.  Ouvrez un terminal à la racine du projet.
2.  Lancez la commande :
    ```bash
    make site/setup
    ```
3.  Le script vous demandera de vous connecter à GitHub et Cloudflare. Suivez les instructions qui s'affichent (connexion via le navigateur).

> **Important** : Cette étape n'est nécessaire qu'une seule fois. Ensuite, vous pourrez utiliser `make site/update` autant de fois que vous le souhaitez.

## 1. Créer le fichier Markdown

Une fois le setup terminé, créez un nouveau fichier `.md` dans le dossier correspondant à votre matière :

- **DevOps** : `devops/devops-content/mon-td.md`
- **UPM** : `devops/upm-content/mon-td.md`

### En-tête (Frontmatter)
Chaque fichier doit commencer par un en-tête pour définir son titre :

```yaml
---
title: "TD X : Mon Titre"
---
```

## 2. Ajouter des images

Si votre TD contient des images (captures d'écran, schémas) :

1.  Créez un dossier pour votre TD dans `static/img/` (ex: `static/img/tdX/`).
2.  Déposez vos images dans ce dossier.
3.  Dans votre fichier Markdown, insérez l'image comme ceci :

```markdown
![Description de l'image](/static/img/tdX/mon-image.png)
```

> **Note** : Le chemin doit toujours commencer par `/static/img/...`.

## 3. Publier les modifications

Une fois votre fichier et vos images prêts :

1.  Ouvrez un terminal dans le dossier du projet.
2.  Lancez la commande suivante :

```bash
make site/update
```

Cette commande va :
- Construire le site localement.
- Pousser les modifications sur GitHub.
- Déployer la nouvelle version sur Cloudflare Pages.

## Résumé de la structure

```text
.
├── devops/
│   └── devops-content/
│       ├── td5.md          # Votre fichier contenu
│       └── ...
├── static/
│   └── img/
│       └── td5/            # Vos images
│           ├── image1.png
│           └── ...
└── Makefile                # Script de déploiement
```
