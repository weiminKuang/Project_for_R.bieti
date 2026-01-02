Project for Population Genomics and Probe Design

This repository contains scripts and workflows for population genomics analyses, including SNP calling, population structure inference, genetic differentiation, isolation by distance, genetic diversity, demographic history reconstruction, and probe design.

0. SNP calling and filtering

01SNP_calling_and_filtering/
- SNP_calling.sh: Script for SNP calling from raw sequencing data.
- SNP_calling.sh.txt: Text version / record of the SNP calling script.
- vcf_filtering.sh: Script for VCF quality control and filtering.
- vcf_filtering.sh_20251229_160700.txt: Logged or archived version of VCF filtering script.

1. Genetic Structure Analysis

02Genetic_structure_analysis/
- PCA.sh: Performs principal component analysis (PCA).
- PCA_20251230_230950.sh: Archived version of PCA script.
- PCA_309.par: Parameter file for PCA analysis.
- ADMIXTURE.sh: Runs ADMIXTURE analysis for population clustering.
- ADMIXTURE_20251229_160700.sh: Archived version of ADMIXTURE script.
- RAxML.sh: Constructs phylogenetic trees using RAxML.
- RAxML_20251230_230950.sh: Archived version of RAxML script.
- Treemix.sh: Infers population splits and migration events using TreeMix.
- Treemix_20251230_230950.sh: Archived version of TreeMix script.

2. Genetic Differentiation, Isolation by Distance, and Genetic Connectivity Analysis

03Genetic_differentiation_Isolation_by_distance_and_Genetic_connectivity_analysis/
- Fst.sh: Calculates genetic differentiation statistics (e.g. FST).
- Fst_20251230_230952.sh: Archived version of FST analysis script.
- BA3-SNP.sh: Runs BAYESASS (BA3-SNP) for recent gene flow estimation.
- BA3-SNP_20251229_160702.sh: Archived version of BA3-SNP script.
- EEMS.sh: Estimates effective migration surfaces using EEMS.
- EEMS_20251230_230952.sh: Archived version of EEMS script.
- Genetic_distance.txt: Pairwise genetic distance matrix.
- Geographic_distance.txt: Pairwise geographic distance matrix.
- 5pop.list.txt: Population list file.
- inter.list.txt: Intermediate population grouping file.
- 309-chain1.ini.txt: Configuration file for demographic or connectivity inference.


3. Genetic Diversity Analysis

04Genetic_diverstity_analysis/
- diversity.sh: Estimates genetic diversity indices.
- diversity_20251230_230950.sh: Archived version of diversity analysis script.
- pop.list.txt: Population definition file.

4. Population Demographic Analysis

05Population_demographic_analysis/
- Fastsimcoal2/: Scripts and files for demographic inference using Fastsimcoal2.
- GONE/: Scripts and outputs for recent effective population size inference using GONE.

5. Probe Design

Probe_design/
- probe_design.sh: Script for SNP selection and probe design.
