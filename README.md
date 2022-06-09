# Skills Football Ontology

## Introduction

Skills football ontology is an university project for Intelligent Web exam. We realized an ontology to extend dbo:SoccerPlayer with informations about the skills of the players (like sprint speed, finishing, tackling and so on).
To implement the ontology we used a tool named Protégé and then we found a dataset (Fifa 21) to import the datas of the skills.  
We implemented a web app using Maven as build system, Java and Jena to interrogate the ontology with SPARQL.  
In the ontology folder you can find the datasets, the ontology for Protégé (.owl) and the ontology for Jena Server (.ttl).

## Installation

If you want to install the web app you have to:
1. Download Apache Jena Fuseki  and install it on your machine;
2. When the installation is finished, you have to start Jena Fuseki from cmd. Go to the directory where you installed it, open cmd, execute the command ```fuseki-server```;
3. When it is started, you can access to control panel of Jena Fuseki from http://localhost:3030/#/;
4. Next step is to create a dataset on Jena Fuseki called “SkillsFootball” and with the button "add data" you have to import the file “SkillsFootball_Ontology.ttl”;
5. Now open the project on Intellij, execute the configuration to build the project and deploy it to TomCat (you must have at least TomCat 9 installed and running o your pc).
Now you can enjoy the project!

## Import ontology Protégé

Download the file skillsFootball_ontology.owl (not .ttl!) from ontology folder, open Protégé > File > Open... and import the owl file.
