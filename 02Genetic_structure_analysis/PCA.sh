#!/usr/bin/bash
cut -f 1-5 309sample.ped > 309sample.pedind
paste 309sample.pedind popname.txt >309sample.ped.ind
smartpca -p 309.par > smartpca.log