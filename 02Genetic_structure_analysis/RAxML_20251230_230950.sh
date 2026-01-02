###### ML_tree analysis #####

#!/usr/bin/bash

#####  Generate a phylip file using vcf2phylip.py #####
python vcf2phylip.py -i 312sample.recode.vcf

##### Construct the Maximum Likelihood (ML) tree using the RAxML #####
raxmlHPC-SSE3 -m GTRGAMMAI -f a -x 12345 -p 12345 -# 100 -s 312sample.recode.min4.phy -n 312sample_ML