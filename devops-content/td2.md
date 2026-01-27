OUPINDRIN Timothy - FI Groupe 2I

# Lab 2 : Managing code as infrastructure (IaC)

## Objectifs du Lab :

- Comprendre l'intérêt de manager IaC
- Déployer une instance EC2 en utilisant un script Bash
- Déployer et configurer une instance EC2 en utilisant Ansible
- Créer une Amazon Machine Image (AMI) avec Packer
- Déployer, mettre à jour et supprimer une instance EC2 en utilisant OpenTofu
- Comprendre comment fonctionne chacun des outils IaC

## Section 1 : L'authentification à AWS en ligne de commande

### 1. Créer un access key

User créé :

![User créé](/static/img/td2/img1.jpg)

Avec une access key associée :

![Access key associée](/static/img/td2/img2.jpg)

On peut alors utiliser la clé pour configurer aws cli (en ligne de commande) avec 'aws configure' :

![Configuration AWS CLI](/static/img/td2/img3.jpg)

'aws sts get-caller-identity' pour verifier que la clé et les permissions sont correctes.

### 2. Setup les variables d'environnement

![Setup variables d'environnement](/static/img/td2/img4.jpg)
![Setup variables d'environnement](/static/img/td2/img5.jpg)

Ainsi pour seulement le terminal actuellement actif, ces variables d'environnement s'appliqueront.

Avec 'aws sts get-caller-identity' on voit que les variables d'environnement sont bien lues et que l'authentification AWS est toujours fonctionnelle !

## Section 2 : Déployer une instance EC2 en utilisant un script Bash

L'objectif de cette section va être d'exécuter un script Bash donné afin de :

- créer les ressources AWS
- lancer l'instance EC2
- récupérer les informations nécessaires pour tester l'application

Après avoir rangé le script à l'emplacement approprié et l'avoir rendu exécutable :

![Script exécutable](/static/img/td2/img6.jpg)

On peut alors l'exécuter. Il génère ainsi Instance ID, Security Group ID et Public IP.

![Exécution du script](/static/img/td2/img7.jpg)

(Image de la page Hello World)

### Remarques importantes :

- On peut se rendre compte que quand on essaie de réexécuter le script une nouvelle fois, ça ne marche pas. D'après l'erreur retournée, le script échoue lors de la seconde exécution car il tente de recréer des ressources AWS portant des noms déjà existants, ce qui n'est pas possible => L'état du système ne reste pas le même après plusieurs exécutions.

- On peut déployer plusieurs instances EC2 avec une unique commande 'aws ec2 run-instances' (en utilisant --count pour le nombre de déploiements ou en faisant appel à une boucle). Les configurations seront similaires entre elles mais auront donc des Instance ID différents.

## Section 3 : Déployer une instance EC2 en utilisant Ansible

L'objectif de cette section sera de permettre à Ansible de provisionner une instance EC2 sur AWS de manière automatique en se basant sur la région et les tags AWS. On finira par déployer l'application Node.js.

En utilisant les fichiers de configuration donnés et en l'exécutant une fois, on arrive à déployer notre Hello World !

![Ansible deployment](/static/img/td2/img8.jpg)

**Remarque :** En l'exécutant une deuxième fois, la plupart des tâches du playbook apparaissent en vert avec le statut 'ok' au lieu de jaune avec 'changed'. C'est la démonstration du principe d'idempotence dans Ansible.

Chaque module Ansible est conçu pour vérifier l'état actuel du système avant d'agir.

- La tâche 'yum' vérifie d'abord si Node.js est déjà installé. Si c'est le cas, elle ne fait rien.
- La tâche 'copy' compare le fichier source (app.js) avec celui de destination. S'ils sont identiques, elle ne le recopie pas.
- La tâche 'shell' avec le paramètre creates: /tmp/node-app.pid vérifie l'existence du fichier PID. S'il existe, elle considère que l'application est déjà démarrée et saute l'exécution.

Pour déployer et configurer plusieurs instances EC2, il faut modifier le playbook de création pour lancer N instances avec le bon tag. Le playbook de configuration et l'inventaire fonctionneront immédiatement à l'échelle sans autre changement.

## Section 4 : Création d'une AMI avec Packer

**Objectif :** Créer une image machine (AMI) avec une application pré-installée.

Dû entre autres à des problèmes de version de Packer, le build ne sera pas successfull malheureusement.

**Remarque :** En relançant packer build, une nouvelle AMI sera créée avec un nom différent => A condition qu'on ait remplacé uuidv4() par legacy_uid(). On aurait alors eu un nouvel identifiant unique à chaque fois.

Si on veut modifier le template pour un autre fournisseur, il nous faudrait ajouter un nouveau bloc source pour ce builder, par exemple source "virtualbox-iso" "ubuntu" {...}.

## Section 5 : Déployer, mettre à jour et détruire une instance EC2 avec OpenTofu

### Output pour 'tofu apply'

![Tofu apply output](/static/img/td2/img9.jpg)

L'instance EC2 s'est lancée. On peut ouvrir le Hello World avec le public id retourné par tofu apply.

Ensuite, on ajoute un tag dans main.tf (mise à jour). Dans notre cas, OpenTofu va update l'instance sur place.

Enfin, on peut tofu destroy pour bien faire comprendre au système que l'on n'utilise plus les ressources créés. Une nouvelle fois, si on tape tofu apply, il va recréer toutes les ressources, car l'état local sait qu'elles ont été détruites.

Pour déployer plusieurs instances, on utilise l'attribut count pour spécifier le nombre d'instances voulues ou on peut utiliser for_each comme boucle.

## Section 6 : Déployer une instance EC2 en utilisant un module OpenTofu

C'est une étape importante pour apprendre à structurer et réutiliser votre code.

Après avoir créé tous les fichiers de config au bon endroit et après tofu apply.

![Module OpenTofu deployment](/static/img/td2/img10.jpg)

On a bien deux instances EC2 dont on peut facilement retrouver leurs public IDs.

Pour ajouter des paramètres comme 'port' ou 'instance_type' au module, il faut :

1. Les déclarer dans variables.tf du module.
2. Les utiliser dans main.tf du module (ex: remplacer 8080 par var.port).
3. Leur passer des valeurs depuis le module racine (main.tf).

Pour déployer plusieurs instances sans duplication, on peut utiliser for_each dans le module racine :

![For_each example](/static/img/td2/img11.jpg)

## Section 7 : Utiliser des modules OpenTofu via Github

Au lieu de référencer un module local (source = "../../modules/ec2-instance"), on va ici référencer un module hébergé dans un dépôt Git.

Après avoir setup un repo github, l'avoir lié à notre dépôt local et tofu apply :

![Github module deployment](/static/img/td2/img12.jpg)

Pour spécifier une version (tag, branche, commit), on peut ajouter un ref à la source :

'source = "github.com/votre-username/opentofu-ec2-module.git?ref=v1.0.0"'

## Conclusion

Au cours de ce Lab 2, on a pu explorer les quatre catégories fondamentales d'outils IaC, chacune résolvant un problème spécifique du cycle de vie de l'infrastructure : Le Script Bash, Ansible, Packer et OpenTofu.

Nous sommes partis d'un script Bash simple pour arriver à une infrastructure déclarative et modulaire avec OpenTofu, et on a pu constater que :

- Les scripts sont rapides mais fragiles.
- Ansible est puissant pour la configuration et exige une gestion minutieuse des accès.
- Packer est le compagnon idéal pour construire des images fiables.
- OpenTofu (ou Terraform) est l'outil de choix pour le provisionnement, offrant un état centralisé et une prédictibilité totale des changements.

Une architecture IaC mature utilise souvent :

1. Packer pour créer une image.
2. OpenTofu pour déployer l'infrastructure (VPC, instances, équilibreurs de charge) en utilisant cette image.
3. Ansible pour les configurations fines et post-déploiement sur les instances (si nécessaire).

Ce lab nous a donné une vision d'ensemble pratique. On sait maintenant identifier les forces de chaque outil et choisir le bon en fonction de la tâche : utiliser un module OpenTofu pour créer un bucket S3, un playbook Ansible pour déployer une application sur un cluster existant, ou un template Packer pour standardiser l'image de base de l'entreprise.