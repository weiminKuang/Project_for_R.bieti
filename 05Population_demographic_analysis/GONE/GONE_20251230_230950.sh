##### GONE code #####
#Use a single dataset as an example.

#!/usr/bin/bash
#step1：Make file 
vcftools --vcf  CR_10.recode.vcf  --plink  --out CR_10
plink --file  CR_10  --make-bed  --out CR_10  --allow-no-sex  --allow-extra-chr 0
plink --bfile  CR_10  --out  CR_10  -recode
#step2：run GONE
bash script_GONE.sh   CR_10
