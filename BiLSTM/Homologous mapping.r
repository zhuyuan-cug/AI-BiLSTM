install.packages("homologene") # Install homologene package
library("homologene") # Load the homologene package
# Enter a list of gene symbol, and an example is given below.
# genelist<-c("Acadm","Eno2","Acadvl")
genelist<-
homolist<-homologene(genelist,inTax=9606,outTax=4932)# Human genes(9606) to yeast genes(4932)