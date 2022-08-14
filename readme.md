## data set
This folder contains the correlation data used in the article.

`Meterials` folder holds the relevant text files.

## BiLSTM
This folder holds the code related to BiLSTM, where the Results folder holds the prediction results. `metrics.py` is used to calculate the relevant evaluation metrics.

In this folder, the Homologous mapping.r file implements the homologous mapping.

### PSGN
This folder holds the PSGN related code.
The codes could be divided into to two parts, one is for PSGN feature generation, and another is used to ensemble classifier training. You should run the PSGN.m firstly and then you can obtain a list of scores for the proteins, then run the test-5-cross.m, then the required ensemble classifier is completed.

## biological validation
This folder holds the relevant result maps.

### GO and KEGG
Both GO analysis and KEGG analysis were performed at the metaspace website. The website can be visited at http://metascape.org/gp/index.html#/main/step1.

### survival analysis
Survival analysis is completed on the GEPIA website. The website can be visited at http://gepia.cancer-pku.cn/detail.php?gene=POLA2###.
