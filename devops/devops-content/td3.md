---
title: "TD3 : How to Deploy Your Apps"
---
>TD3 : How to Deploy Your Apps

>Florian BOZEL

# Part 1: Server Orchestration with Ansible

## Step 2: Creating EC2 Instances with Ansible
J'ai dû changer le type d'instance en `t3.micro` car le `t2` n'est pas compris dans le Free tier.
![EC2 Instances](/static/img/td3/1.png)
## Step 4: Deploying the Sample Node.js Application
J'ai rencontré un problème qui m'a coûté du temps pour cette étape. L'inventaire AWS EC2 génère des groupes basés sur les tags. Et quand l'inventaire génère un groupe basé sur un tag, il ajoute `_` au début du nom du groupe. Dans mon cas, mes instances ont le tag `Ansible: sample_app_instances`, donc l'inventaire génère `_sample_app_instances`. 

Sauf que mon fichier `group_vars` s'appelait `sample_app_instances` sans le `_` donc mon playbook échouait. 

Pour corriger ça, je l'ai renommé avec un `_` au début et pareillement pour le `hosts` dans le playbook. 

![Resultats](/static/img/td3/2.png)

Les IPs publiques sont:
- 3.148.215.71
- 3.143.205.98
- 3.142.199.103

On teste avec le curl:
![Resultats](/static/img/td3/3.png)

## Step 5: Setting Up Nginx as a Load Balancer
J'ai rencontré la même erreur qu'avec **Node.js**. J'ai corrigé ce problème de la même manière qu'avant + il fallait adapter le template Nginx pour utiliser le dict `_sample_app_instances`.

![Resultats](/static/img/td3/4.png)

L'IP est 3.142.195.42.

![Resultats](/static/img/td3/5.png)

## Step 6: Implementing Rolling Updates

![Resultats](/static/img/td3/6.png)

---

# Part 2: VM Orchestration with Packer and OpenTofu

## Step 3: Deploying an Application Load Balancer (ALB)
Après avoir tout configuré :

![Resultats](/static/img/td3/7.png)

## Step 4: Implementing Rolling Updates with ASG Instance Refresh

![Resultats](/static/img/td3/8.png)

---

# Part 3: Container Orchestration with Docker and Kubernetes

## Step 1: Building and Running the Docker Image Locally

![Resultats](/static/img/td3/9.png)

## Step 2: Deploying the Application to a Local Kubernetes Cluster

![Resultats](/static/img/td3/10.png)

## Step 3: Performing a Rolling Update

![Resultats](/static/img/td3/11.png)

---

# Part 4: Deploying Applications Using Serverless Orchestration with AWS Lambda

## Step 4: Deploy the Lambda Function

![Resultats](/static/img/td3/12.png)

![Resultats](/static/img/td3/13.png)

## Step 7: Deploy the API Gateway Configuration
La fonction a été déployée ici :
```
api_endpoint = "https://e62g30eddj.execute-api.us-east-2.amazonaws.com"
```

Avec un curl, on a bien:

![Resultats](/static/img/td3/14.png)

## Step 9: Update the Lambda Function

---

Sur le dashboard des instances EC2 AWS, on retrouve toutes nos instances:

![Resultats](/static/img/td3/15.png)