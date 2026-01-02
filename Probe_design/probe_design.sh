#The probe extracted autosomal variants from the whole genome of Yunnan golden snub-nosed monkeys, and then filtered the variants
#hwe 0.001
#!/bin/bash
for chr in {1..21}; do
    vcftools --vcf Rbie.Pop.Chr${chr}.HC.FinalPASS.MissRatio.vcf \
             --hwe 0.001 \
             --recode \
             --out Rbie.Chr${chr}_filter1
done

#maf 0.05
#!/bin/bash
for chr in {1..21}; do
    vcftools --vcf Rbie.Chr${chr}_filter1.vcf \
             --maf 0.05 \
             --recode \
             --out Rbie.Chr${chr}_filter2
done

#Remove_CpG_regions
/software/CpGIScan-master/cpgiscan --length 500 --gcc 55 --oe 0.65 Rbieti-Sequle-HiCV2.fa > CpG_regions.txt			 
for chr in {1..21}; do
    vcftools --vcf Rbie.Chr${chr}_filter2.vcf \
             --exclude-bed CpG_regions.txt \
             --recode \
             --out Rbie.Chr${chr}_filter3
			 
#Remove_gene_regions
for chr in {1..21}; do
    vcftools --vcf Rbie.Chr${chr}_filter3.vcf \
             --exclude-bed Rbieti-Sequle-HiCV2.final.Annotated.bed \
             --recode \
             --out Rbie.Chr${chr}_filter4
			 
#Remove_duplicate_areas
/software/biosoft/RepeatMasker/RepeatMasker -pa 10 -gff Rbieti-Sequle-HiCV2.fa
#!/bin/bash
BED_BASE="/repeatmasker/repeatmasker_chr"

for chr in {1..21}; do
    vcftools --vcf "Rbie.Chr${chr}_filter4.recode.vcf" \
             --exclude-bed "${BED_BASE}${chr}.bed" \
             --recode \
             --out "Rbie.Chr${chr}_filter5"
done

#pick_high_pi_positions
#merge vcfs
gatk MergeVcfs -I Rbie.Chr01_filter5.recode.vcf -I Rbie.Chr02_filter5.recode.vcf -I Rbie.Chr03_filter5.recode.vcf -I Rbie.Chr04_filter5.recode.vcf -I Rbie.Chr05_filter5.recode.vcf -I Rbie.Chr06_filter5.recode.vcf -I Rbie.Chr07_filter5.recode.vcf -I Rbie.Chr08_filter5.recode.vcf -I Rbie.Chr09_filter5.recode.vcf -I Rbie.Chr10_filter5.recode.vcf -I Rbie.Chr11_filter5.recode.vcf -I Rbie.Chr12_filter5.recode.vcf -I Rbie.Chr13_filter5.recode.vcf -I Rbie.Chr14_filter5.recode.vcf -I Rbie.Chr15_filter5.recode.vcf -I Rbie.Chr16_filter5.recode.vcf -I Rbie.Chr17_filter5.recode.vcf -I Rbie.Chr18_filter5.recode.vcf -I Rbie.Chr19_filter5.recode.vcf -I Rbie.Chr20_filter5.recode.vcf -I Rbie.Chr21_filter5.recode.vcf -O Rbie.vcf

#site-pi
for chr in {1..21}; do
    vcftools --vcf "Rbie.Chr${chr}_filter5.recode.vcf" \
             --site-pi "${BED_BASE}${chr}.bed" \
             --out "Rbie.Chr${chr}_filter5"
for chr in {1..21}; do
    input_file="Rbie.Chr${chr}_filter5_site_pi"  
    output_file="Rbie.Chr${chr}_filter5.site.pi.pick"
    awk '$3 > 0.4' "${input_file}" > "${output_file}"
done
#pick_high_pi_positions
cat *site.pi.pick > Rbie.site.pi.pick
awk '{print $1,$2}' > Rbie.site.pi.pick.position.txt
#get_final_vcf
vcftools --vcf Rbie.vcf \
	--out Rbie.pi.vcf \
	--positions Rbie.site.pi.pick.position.txt \
	--recode

