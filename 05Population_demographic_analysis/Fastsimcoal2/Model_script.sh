#Model_script

#modeling

#!/bin/bash
/software/fsc26/fsc26_linux64/fsc26 -t 5groups.tpl -e 5groups.est -m -n 10000 -N 1000000 -M 0.001 -l 20 -L 40 -q -c4

#Best_model_bootstrap
/software/fsc26/fsc26_linux64/fsc26 -i 5groups_boot.par -n100 -j -s0 -x –I -q -c5 -m
/software/fsc26/fsc26_linux64/fsc26 -t 5groups_boot.tpl -e 5groups_boot.est -m -n 10000 -N 1000000 -M 0.001 -l 20 -L 40 -q -c4 –initvalues 5groups_boot.pv
