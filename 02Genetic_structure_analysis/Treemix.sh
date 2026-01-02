#Treemix

#!/usr/bin/bash
vcftools --vcf 312sample.recode.vcf \
         --plink \
         --out 312sample
plink --file 312sample --make-bed --out 312sample --allow-no-sex --allow-extra-chr 0
plink --bfile 312sample --freq --missing --within 5pop.txt --out 5pop --allow-no-sex --allow-extra-chr 0

gzip 5pop.frq.strat

python plink2treemix.py 5pop.frq.strat.gz 5pop.treemix.frq.gz
treemix -i 5pop.treemix.frq.gz -root outgroup -o 5pop_TreeMix_ML_M0.1 -bootstrap 1000 -m 0  > treemix1_0_log