#!/bin/bash

#SBATCH -n 12
#SBATCH -N 1
#SBATCH -t 7000:00:00
#SBATCH -p wzhcnormal
#SBATCH --mem=64G
#SBATCH -o /work/home/Landscape/J/aspect.stdout
#SBATCH -e /work/home/Landscape/J/aspect.stderr
#SBATCH --job-name="aspect"

cd /work/home/Landscape/

/public/software/VersionHub/R/4.4.3/Rscript - << 'EOF'

library(ResistanceGA)
library(gdistance)
library(raster)
library(readxl)

output_dir <- "/work/home/Landscape/aspect/"
data_dir <- "/work/home/Landscape/data"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

continuous_surface <- raster(file.path(data_dir, "aspect.asc"))
writeRaster(continuous_surface,filename = file.path(output_dir, "cont.asc"),overwrite = TRUE)

samples <- read.csv(file.path(data_dir, "site.csv"), header = TRUE, sep = ",")
write.table(samples[,c(2,3)],file = file.path(output_dir, "samples.txt"),sep = "\t",col.names = FALSE,row.names = FALSE)

sample_locales <- SpatialPoints(samples[, c(2, 3)])

pdf(file = file.path(output_dir, "surface_plot.pdf"), width = 8, height = 6)
plot(continuous_surface, main = "Continuous Resistance Surface")
plot(sample_locales, pch = 16, col = "blue", add = TRUE)
dev.off()

GA.inputs <- GA.prep(ASCII.dir = output_dir,
                     Results.dir = output_dir,
                     max.cat = 500,
                     max.cont = 500,
                     select.trans = list("A"),
                     method = "LL",
                     seed = 555)

genetic_mat <- as.matrix(read_excel(file.path(data_dir, "dis.xls")))
gdist.response <- as.vector(genetic_mat[lower.tri(genetic_mat)])


gdist.inputs <- gdist.prep(n.Pops = length(sample_locales),
                           samples = sample_locales,
                           response = gdist.response,
                           method = "commuteDistance")

SS_RESULTS <- SS_optim(gdist.inputs = gdist.inputs,GA.inputs = GA.inputs)

SS_table <- data.frame(Optimized = t(SS_RESULTS$ContinuousResults[c(9:11)]))
rownames(SS_table) <- c("Transformation Type", "Optimal Shape Parameter", "Optimal Max Parameter")
colnames(SS_table) <- c("Real Data Optimization Results")
print(SS_table)
EOF
