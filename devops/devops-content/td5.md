---
title: "TD5 : DevOps"
---

## 1. Clonage et Initialisation

Après avoir cloné le repository nommé `devops-lab4`, j'ai suivi les étapes pour créer le dossier `td5` et effectuer une recopie du dossier `td4`.

À la suite du clonage, j'ai également créé le fichier YAML pour le déploiement CI/CD.

![Capture initialisation](/static/img/td5/image1.png)

## 2. Test Workflow

Création de la branche `test-workflow` pour introduire une erreur et tester les jobs.

![Branche test-workflow](/static/img/td5/image2.png)

### Modification de la réponse de l'app

![Modification response](/static/img/td5/image3.png)

### Commit de l'erreur introduite

![Commit erreur](/static/img/td5/image4.png)

### Pull Request & Erreur CI

Création de la pull-request. On constate que le workflow de tests échoue :

![Echec workflow](/static/img/td5/image5.png)
![Details echec](/static/img/td5/image6.png)

### Correction

Correction du test Jest pour obtenir le résultat souhaité :

![Correction Jest](/static/img/td5/image7.png)

Après correction, le test passe correctement dans l'historique des commits :

![Succes test](/static/img/td5/image8.png)

## 3. OpenTofu

Création de la branche de travail.

![Branche OpenTofu](/static/img/td5/image9.png)

### Création du Root Module

![Root module](/static/img/td5/image10.png)

### Questions 5.5 et 5.6 : Modification du main.tf

![Modification main.tf](/static/img/td5/image11.png)

### Configuration AWS

![Config AWS](/static/img/td5/image12.png)

### Configuration du Workflow OpenTofu (YAML)

![Config YAML Tofu](/static/img/td5/image13.png)

L'exécution des jobs a réussi, marquant la fin de la phase de setup.

## 4. Deployment Pipelines

### Configuration Backend S3

Code pour configurer le backend et le bucket S3 :

![Backend S3](/static/img/td5/image14.png)

### Fichiers Workflow

**tofu-apply.yml** après configuration du bucket :

![Tofu apply](/static/img/td5/image15.png)

**tofu-plan.yml** :

![Tofu plan](/static/img/td5/image16.png)

## 5. Testing the Deployment Pipeline

1. Changement du texte dans le body pour une nouvelle valeur.

   ![Changement body](/static/img/td5/image17.png)

2. Modification de `deploy.tftest.hcl` en mettant « DevOps Labs ».

   ![Modif test hcl](/static/img/td5/image18.png)

3. Commit des modifications.

   ![Commit modifs](/static/img/td5/image19.png)

4. Vérification des workflows.

   ![Workflow success](/static/img/td5/image20.png)
   ![Liste workflows](/static/img/td5/image21.png)
   ![Et enfin](/static/img/td5/image22.png)

Un e-mail de notification confirme la bonne exécution des jobs.

![Mail notification](/static/img/td5/image23.png)
