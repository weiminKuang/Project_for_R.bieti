##### BayesAss3-SNPs simulation #####

#!/usr/bin/bash
#Make file
/stacksStr2immanc.pl -p "NR,CNR,CR,SER,SWR" -s 5groups_genotype_new.txt  -o 5groups.immanc
#BayesAss3-SNPs code
/software/BA3/BayesAss3-SNPs-master/BA3-SNPS-Ubuntu64  -F 5groups-new.immanc -l 3966 -v -g -u -t -a0.3 -f0.01 -n100 -o 5groups.txt > 5groups.log