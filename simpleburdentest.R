#R function to perform a gene based test for overrepresentation (enrichment) of rare variants.  Input file is a QC'd file from PLINK 
#produced with the --recodeA command so genotypes represented by additive coding.  This file must only contain rare variants.  Input 
#files that contain common variants may report an error since more variants than subjects may be counted and the fisher's t-test will 
#return an error in that case.  Input requires a file read into R using the read.table() function and saved as an objects called 'data'.  
#A header line is not required.  To use the 'burden' R function use the command 'burden(x,y,gene_name)' where x is column number 
#containing the first variant in the gene, y is the column number containing the last variant in the gene, and gene_name is a string 
#containing the name of the gene (enter this value in quotes).  Missing data in the input is allowed and as per the --recodeA command 
#in PLINk should be is coded as NA.  Results from this function will include the name of the gene, the unadjusted p-value, the 95% 
#CI, and the odds ratio (in that order).

burden<-function(A,B,gene_name){

cases_w_variant<-sum(data[which(data$PHENOTYPE==2),A:B]>0, na.rm=T)
controls_w_variant<-sum(data[which(data$PHENOTYPE==1),A:B]>0, na.rm=T)
cases_missing_genotypes<-sum(is.na(data[which(data$PHENOTYPE==2),A:B]>0))
controls_missing_genotypes<-sum(is.na(data[which(data$PHENOTYPE==1),A:B]>0))

#number of controls
controlsum<-sum(data$PHENOTYPE==1)

#number of cases
casesum<-sum(data$PHENOTYPE==2)

#number of carriers of the risk allele
riskvarsum<-sum(data[,A:B]>0)

W<-cases_w_variant
X<-controls_w_variant
Y<-casesum-cases_w_variant-cases_missing_genotypes
Z<-controlsum-controls_w_variant-controls_missing_genotypes

#"alternative='greater'" will give statistics for enrichment, change to "alternative='less'" for depletion
results<-fisher.test(matrix(c(W,X,Y,Z),2,2),alternative='greater')
genename<-gene_name
print(genename)
print(results$p.value)
print(results$conf.int)
print(results$estimate)


}
