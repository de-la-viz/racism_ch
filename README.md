# Norme pénale antiraciste en Suisse | _Swiss Anti-Racist Penal Norm_

La Commission Fédérale contre le Racisme (CFR) répertorie depuis 1995 les décisions et les jugements relatifs à l’art 261bis du code pénal (norme pénale antiraciste) des différentes instances judiciaires de Suisse et les mets à disposition du public et des spécialistes dans son [recuil de cas juridiques](https://www.ekr.admin.ch/prestations/f269.html).  

Cependant, cette base données permet uniquement de consulter les cas un par un. Il n'est pas possible d'obtenir une vue d'ensemble autre que les [quelques statistiques présentées](https://www.ekr.admin.ch/prestations/f272.html). Ces données sont en libre accès, mais, après demande, il se trouve que la CFR est incapable de les délivrer sous forme tabulaire, et ce pour une raison technique et non juridique ou légale. Sous ce format, elles ne sont donc que de peu d'utilité pour le public. 

Le but de ce projet est de collecter ces données (web scraping) puis de les mettre en valeur pour pouvoir les communiquer avec le public. Ceci dans le but de renseigner le débat public sur le racisme en Suisse.   

---  

_Collection, analysis, and visualization of the decisions and judgements relating to Article 261bis of the Penal Code (anti-racist penal norm) from the various judicial bodies in Switzerland._

_Since 1995 the Federal Commission against Racism (FCR) has been compiling a list of decisions and judgements relating to article 261bis of the Penal Code (anti-racist penal norm) from the various judicial bodies in Switzerland and making them available to the public and specialists in its [collection of legal cases](https://www.ekr.admin.ch/prestations/f269.html)._  

_However, this database only allows consulting the cases one by one. It is not possible to obtain an overview other than the [some statistics presented](https://www.ekr.admin.ch/prestations/f272.html). These data are freely available, but upon request, the FCR is unable to issue them in tabular form for a technical and not a legal or legal reason. In this format, they are therefore of little use to the public._ 

_The aim of this project is to collect these data (web scraping), analyze them, and communicate them to the public. The aim is to inform the public debate on racism in Switzerland._   

---  

## Les données: décisions et jugements cantonaux rendus en vertu de l’art. 261bis CP

Les autorités cantonales sont tenues de communiquer au Service de Renseignement de la Confédération (SRC) l’ensemble desdits décisions et jugements relevant de l’art. 261bis CP. Ces décisions et jugements cantonaux sont transmis ensuite transmis à la CFR par le SRC sous forme anonyme, c'est-à-dire sans mention du nom. Finalement, la CFR prépare une version entièrement anonymisée de chaque décision/jugement, qui peut être téléchargée au format PDF sur son [recuil de cas juridiques](https://www.ekr.admin.ch/prestations/f269.html).  

### Scraping des données

Les données de tous les cas présents sur le [recuil de cas juridiques pour le droit pénal](https://www.ekr.admin.ch/prestations/f518.html) sont extraites par le scraper [/code/scraper.ipynb](https://github.com/de-la-viz/racism_ch/blob/master/code/scraper.ipynb) puis sauvées au format .csv ([/data/CFR_1995-2018.csv](https://github.com/de-la-viz/racism_ch/blob/master/data/CFR_1995-2018.csv)) et .json ([CFR_1995-2018.json](https://github.com/de-la-viz/racism_ch/blob/master/data/CFR_1995-2018.json)).   

#### Informations sur les données

**Taille**: 11.3Mb (.csv)
**Nombre de cas**: 910 (1995-2018)
**Source**: [https://www.ekr.admin.ch/prestations/f518.html](https://www.ekr.admin.ch/prestations/f518.html)
**Langue**: le contenu (textes, commentaires) des cas est dans la langue où ils ont été traités: Allemand, Français ou Italien. Cependant, tous les mots clés sont en français, puisque c'est la version française de la base de données qui a été scrapée (pour l'instant, une extraction à partir de la version allemande et italienne est prévue).  
**License**: [(CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/)

| Variable      | Description   |
| ------------- |---------------|
| original_case | ... |
| current_case      | ...      |
| name | ... |
| location | ... |
| name | ... |
| url | ... |
| history | ... |
| act | ... |
| protection_object | ... |
| specific_questions | ... |
| authority | ... |
| authors | ... |
| victims | ... |
| means | ... |
| social_env | ... |
| ideology | ... |
| html_text | ... |
| text | ... |



## Work in progress ...



