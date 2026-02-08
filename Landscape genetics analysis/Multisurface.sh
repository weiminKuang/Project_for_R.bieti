#!/bin/bash

#SBATCH -n 12
#SBATCH -N 1
#SBATCH -t 7000:00:00
#SBATCH -p wzhcnormal
#SBATCH --mem=64G
#SBATCH -o /work/home/Landscape/J/aspect-places-populationdensity-roads-vegetation-waterways.stdout
#SBATCH -e /work/home/Landscape/J/aspect-places-populationdensity-roads-vegetation-waterways.stderr
#SBATCH --job-name="aspect-places-populationdensity-roads-vegetation-waterways"

cd /work/home/Landscape/

/public/software/VersionHub/R/4.4.3/Rscript - << 'EOF'
library(ResistanceGA)
library(raster)
library(sp)
library(ggplot2)
library(gdistance)
library(readxl) 

data_dir <- "/work/home/Landscape/data"
write.dir <- "/work/home/Landscape/aspect-places-populationdensity-roads-vegetation-waterways/"
if (!dir.exists(write.dir)) {
  dir.create(write.dir, recursive = TRUE)
}

figs.dir <- file.path(write.dir, "figures") 
if (!dir.exists(figs.dir)) {
  dir.create(figs.dir, recursive = TRUE)
}

aspect_surface <- raster(file.path(data_dir, "aspect.asc"))
writeRaster(aspect_surface, filename = file.path(write.dir, "aspect.asc"), overwrite = TRUE)

places_surface <- raster(file.path(data_dir, "places.asc"))
writeRaster(places_surface, filename = file.path(write.dir, "places.asc"), overwrite = TRUE)

populationdensity_surface <- raster(file.path(data_dir, "populationdensity.asc"))
writeRaster(populationdensity_surface, filename = file.path(write.dir, "populationdensity.asc"), overwrite = TRUE)

roads_surface <- raster(file.path(data_dir, "roads.asc"))
writeRaster(roads_surface, filename = file.path(write.dir, "roads.asc"), overwrite = TRUE)

waterways_surface <- raster(file.path(data_dir, "waterways.asc"))
writeRaster(waterways_surface, filename = file.path(write.dir, "waterways.asc"), overwrite = TRUE)

vegetation_surface <- raster(file.path(data_dir, "vegetation.asc"))
writeRaster(vegetation_surface, filename = file.path(write.dir, "vegetation.asc"), overwrite = TRUE)

samples <- read.csv(file.path(data_dir, "site.csv"), header = TRUE, sep = ",")
write.table(samples[,c(2,3)], file = file.path(write.dir, "samples.txt"), sep = "\t", col.names = FALSE, row.names = FALSE)
sample.locales <- SpatialPoints(samples[, c(2, 3)])

r.stack <- stack(
  aspect_surface,
  places_surface,
  populationdensity_surface,
  roads_surface,
  waterways_surface,
  vegetation_surface
)

pdf(file.path(figs.dir, "Fig1_Single_r.stack.pdf"), width = 24, height = 6)
par(mfrow = c(1, 6), mar = c(1, 1, 2, 1), oma = c(0,0,1,0)) 

plot(r.stack[[1]], main = r.stack[[1]]@data@names, col = topo.colors(10), axes=F, box=F)
plot(sample.locales, pch = 16, col = "blue", cex=0.8, add = TRUE)

plot(r.stack[[2]], main = r.stack[[2]]@data@names, col = topo.colors(10), axes=F, box=F)
plot(sample.locales, pch = 16, col = "blue", cex=0.8, add = TRUE)

plot(r.stack[[3]], main = r.stack[[3]]@data@names, col = topo.colors(10), axes=F, box=F)
plot(sample.locales, pch = 16, col = "blue", cex=0.8, add = TRUE)

plot(r.stack[[4]], main = r.stack[[4]]@data@names, col = topo.colors(10), axes=F, box=F)
plot(sample.locales, pch = 16, col = "blue", cex=0.8, add = TRUE)

plot(r.stack[[5]], main = r.stack[[5]]@data@names, col = topo.colors(10), axes=F, box=F)
plot(sample.locales, pch = 16, col = "blue", cex=0.8, add = TRUE)

plot(r.stack[[6]], main = r.stack[[6]]@data@names, col = topo.colors(10), axes=F, box=F)
plot(sample.locales, pch = 16, col = "blue", cex=0.8, add = TRUE)

par(mfrow = c(1, 1), mar = c(5,4,4,2)+0.1)
dev.off()

GA.inputs <- GA.prep(
  ASCII.dir = r.stack,
  Results.dir = write.dir, 
  max.cat = 500,
  max.cont = 500, 
  seed = 555,
  parallel = 4,
  select.trans = list("A", "A", "A", "A", "A", NA)
)

genetic_mat <- as.matrix(read_excel(file.path(data_dir, "dis.xls")))
gdist.response <- as.vector(genetic_mat[lower.tri(genetic_mat)])

gdist.inputs <- gdist.prep(
  n.Pops = length(sample.locales),
  response = gdist.response,）
  samples = sample.locales,
  method = 'commuteDistance'
)

cat("Start multi-factor optimization, output directory:", write.dir, "\n")
Multi.Surface_optim <- MS_optim(
  gdist.inputs = gdist.inputs,
  GA.inputs = GA.inputs
)

cat("Analysis completed")
EOF