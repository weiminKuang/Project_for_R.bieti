##### Admixture analysis for K=1 to 20 #####
#Using one individual as an example

#!/usr/bin/bash
for K in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do admixture  --cv 1.bed $K | tee log${K}.out; done
###### Extract cross-validation (CV) errors #####
grep -h CV ./log*.out > ./admix.CV.txt