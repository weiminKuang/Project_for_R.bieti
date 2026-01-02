##### Fst evaluation by stacks2 #####

#!/usr/bin/bash
/software/stacks2/stacks-2.64/populations -V 309sample.recode.vcf -M 5pop.list.txt --threads 10 --smooth --fstat -O ./5pop
/software/stacks2/stacks-2.64/populations -V 309sample.recode.vcf -M inter.list.txt --threads 10 --smooth --fstat -O ./intern