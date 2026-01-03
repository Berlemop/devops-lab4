# Lab 1 – An Introduction to Deploying Apps

**Auteur :** Keveen Bouendja  
**Filière :** E4FI  
**UE :** Ecoconception et analyse du cycle de vie (Devops Data)  
**Enseignant :** Badr Tajini  

## Sommaire
- [1. Objectif du TP](#1-objectif-du-tp)
- [2. Exécution locale de l’application](#2-exécution-locale-de-lapplication)
- [3. Déploiement via une plateforme PaaS (Render)](#3-déploiement-via-une-plateforme-paas-render)
- [4. Déploiement via une infrastructure IaaS (AWS EC2)](#4-déploiement-via-une-infrastructure-iaas-aws-ec2)
- [5. Conclusion](#5-conclusion)


## 1. Objectif du TP

L’objectif de ce TP est de comprendre les principes fondamentaux du déploiement d’une application web :
- exécution locale,
- déploiement sur une plateforme PaaS,
- déploiement sur une infrastructure IaaS (AWS EC2).


## 2. Exécution locale de l’application

Sur linux, nous avons crée un dossier contenant notre application Javascript avec les commandes suivantes : 

\$ mkdir devops_base  
\$ cd devops_base  
\$ mkdir -p ch1/sample-app  
\$ cd ch1/sample-app  
\$ nano app.js  

(contenu du fichier app.js : Simple Hello World lancer sur le port 8080 en local)  
>*const http = require('http');  
const server = http.createServer((req, res) => {
res.writeHead(200, { 'Content-Type': 'text/plain' });
res.end('Hello, World!\n');
});  
const port = process.env.PORT || 8080;
server.listen(port,() => {
console.log(`Listening on port ${port}`);
});*

Ensuite on lance l'application avec $ node app.js

Pour finir l'application est déployé en local sur le port 8080 donc il suffit d'ouvrir dans le navigateur http://localhost:8080 pour voir le résultat. 

![Résultat app local](\static\img\td1\screen_local.png)

## 3. Déploiement via une plateforme PaaS (Render)

L'une des facons de déployer notre application sur un server est d'utilisé une plateforme PaaS (Platform as a Service) comme Render. c'est assez haut niveau donc on a pas géré beaucoup de détails ( build system, framework,
Docker image, etc..).   
Nous avons utilisé Render , il faut créer un compte puis "deploy a new web service" puis utilisé nous avons utilisé un github public comme code source de notre appli et choisi quelques parametres comme le nom , le chemin et la commande de départ de l'application avant de la déployer. 
on trouve sur l'appli le lien vers notre appli déployée https://sample-app-1iyu.onrender.com .  

![Résultat app PaaS](\static\img\td1\screen_PaaS.png)

## 4. Déploiement via une infrastructure IaaS (AWS EC2)
Les "infrastructure as a service" sont des moyens de déployer notre application sur un serveur avec plus de flexibilité et de controle. 

Après la création d’un compte AWS, un utilisateur **IAM** est créé afin d’éviter l’utilisation du compte root pour des raisons de sécurité.  
L’utilisateur IAM se voit attribuer la politique **AdministratorAccess** afin de pouvoir réaliser l’ensemble des opérations nécessaires au TD.

Une instance EC2 est ensuite déployée avec les paramètres suivants :
- **Système d’exploitation** : Amazon Linux
- **Type d’instance** : t2.micro ou t3.micro (éligible au free tier)
- **Adresse IP publique** : activée
- **Groupe de sécurité** : autorisation du trafic HTTP entrant (port 80)

Ces choix permettent d’héberger une application web accessible depuis Internet.


Un script *User Data* est utilisé pour automatiser la configuration du serveur au premier démarrage :
- Installation de Node.js
- Création du fichier `app.js`
- Lancement de l’application Node.js en arrière-plan

Ce script permet de déployer l’application sans connexion manuelle au serveur.

Une fois l’instance en état **Running**, l’adresse IP publique de l’instance est récupérée depuis la console AWS.  
En accédant à l’URL suivante dans un navigateur : http://56.228.31.53/

![Résultat app PaaS](..\..\static\img\td1\screen_iaaS.png)
