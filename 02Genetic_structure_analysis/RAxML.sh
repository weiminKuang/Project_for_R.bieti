#ML_tree

#!/usr/bin/bash
python vcf2phylip.py -i 312sample.recode.vcf
raxmlHPC-SSE3 -m GTRGAMMAI -f a -x 12345 -p 12345 -# 100 -s 312sample.recode.min4.phy -n 312sample_ML