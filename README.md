# simple_burden_t-test
Short Description: Calculate the burden of rare variants using Fisher's t-test


##Input Notes:
Input file is a QC'd file from PLINK produced with the --recodeA command so genotypes represented by additive coding.  This file must only contain rare variants.  Input files that contain common variants may report an error since more variants than subjects may be counted and the Fisher's t-test will return an error in that case.  Input requires a file read into R using the read.table() function and saved as an objects called 'data'.  A header line is not required.  

##Usage:
To use the 'burden' R function use the command 'burden(x,y,gene_name)' where x is column number containing the first variant in the gene, y is the column number containing the last variant in the gene, and gene_name is a string containing the name of the gene (enter this value in quotes).  Missing data in the input is allowed and as per the --recodeA command in PLINK should be is coded as NA.  Results from this function will include the name of the gene, the unadjusted p-value, the 95% CI, and the odds ratio (in that order).
