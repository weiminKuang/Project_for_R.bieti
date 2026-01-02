#Low-quality filtering
grep -v "LowQual" 333sample.Raw.Marked.vcf > 333sample.No.Lowqual.vcf
#Filtering of redundant loci
vcftools --vcf 333sample.No.Lowqual.vcf --positions RB_chr.position --recode --recode-INFO-all  --out 333sample.filter1
#remove multi-nucleotide variants 
vcftools --vcf 333sample.filter1.recode.vcf --min-alleles 2 --max-alleles 2 --recode --recode-INFO-all  --out 333sample.filter2
#remove indels
vcftools --vcf 333sample.filter2.recode.vcf --remove-indels --recode --recode-INFO-all  --out 333sample.filter3
#minQ 30  
vcftools --vcf 333sample.filter3.recode.vcf --minQ 30 --recode --recode-INFO-all  --out 333sample.filter4
#maf 0.05  
vcftools --vcf 333sample.filter4.recode.vcf --maf 0.05 --recode --recode-INFO-all  --out 333sample.filter5
#max-missing 0.8
vcftools --vcf 333sample.filter5.recode.vcf --max-missing 0.8 --recode --recode-INFO-all --out 333sample.filter.final
#relationship(cutoff duplicate individuals and first-degree relatives)
plink2 --vcf 333sample.filter.final.vcf --make-king --out 333sample
#pick samples
vcftools --vcf 333sample.filter.final.vcf --keep list_file309.txt  --recode --recode-INFO-all --out 309sample