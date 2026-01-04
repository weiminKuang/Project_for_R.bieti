#!/bin/bash
#SBATCH --job-name=SW_100Runs
#SBATCH --partition=bio
#SBATCH -N 1
#SBATCH --ntasks-per-node=20
#SBATCH --mem=100G
#SBATCH --output=fsc.stout
#SBATCH --error=fsc.sterr
source /public/software/profile.d/apps_Anaconda3-2024.10.sh
cd /public/home/ynuhjy/Kuangwm/Rbieti_Project/VCF/SW_100Runs
for i in {01..100};do cd Run$i; ./fsc28 -t SW.tpl -e SW.est -m -0 -C 10 -n 100000 -L 40 -s 0 -M -y4 -c3; cd ../;done

