#!/bin/bash

##### Model_script ##### 
##### Using a data set as an example #####
# Step 1: Identify the values for projecting down each population
python /easySFS/easySFS.py -i file1.recode.vcf -p 5groups_4 -a -f --proj 48,36,108,12,36
#run Fastsimcoal
/software/fsc26/fsc26_linux64/fsc26 -t 5groups.tpl -e 5groups.est -m -n 10000 -N 1000000 -M 0.001 -l 20 -L 40 -q -c4
#Best_model_bootstrap
/software/fsc26/fsc26_linux64/fsc26 -i 5groups_boot.par -n100 -j -s0 -x –I -q -c5 -m
/software/fsc26/fsc26_linux64/fsc26 -t 5groups_boot.tpl -e 5groups_boot.est -m -n 10000 -N 1000000 -M 0.001 -l 20 -L 40 -q -c4 –initvalues 5groups_boot.pv
