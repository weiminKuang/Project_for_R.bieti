#!/bin/bash

#SBATCH -n 12
#SBATCH -N 1
#SBATCH -t 7000:00:00
#SBATCH -p wzhcnormal
#SBATCH --mem=64G
#SBATCH -o /work/home/Landscape/Bootstrap/J/Bootstrap.stdout
#SBATCH -e /work/home/Landscape/Bootstrap/J/Bootstrap.stderr
#SBATCH --job-name="Bootstrap"

cd /work/home/Landscape/Bootstrap

/public/software/VersionHub/R/4.4.3/Rscript - << 'EOF'

library(ResistanceGA)
library(readxl)
library(sp)

config_csv_path <- "/work/home/Landscape/out.csv"
genetic_xls_path <- "/work/home/Landscape/data/dis.xls"
sites_csv_path <- "/work/home/Landscape/data/site.csv"
output_dir <- "/work/home/Landscape/Bootstrap/"
null_model_path <- "/work/home/Landscape/Goe/Goe.csv"

if (!file.exists(config_csv_path)) {
  stop(paste("Config file not found ->", config_csv_path))
}
config_df <- read.csv(config_csv_path, stringsAsFactors = FALSE)

required_cols <- c("name", "cd", "k", "type")
if (!all(required_cols %in% colnames(config_df))) {
  missing_cols <- setdiff(required_cols, colnames(config_df))
  stop(paste("The configuration file is missing required columns：", paste(missing_cols, collapse = ", ")))
}

n_factors <- nrow(config_df)
cat("Successfully read", n_factors, "factor combination configurations\n")

mat.list <- list()
k_values <- c()
mod.names <- c()

for (i in 1:n_factors) {
  factor_name <- config_df$name[i]
  cd_path <- config_df$cd[i]
  
  cat("\nProcessing the", i, "th factor combination:", factor_name, "\n")
  
  if (!file.exists(cd_path)) {
    warning(paste("Resistance matrix file does not exist, skipping ->", cd_path))
    next
  }
  cd_mat <- as.matrix(read.csv(cd_path, header = FALSE))
  mat.list[[i]] <- cd_mat
  mod.names[i] <- factor_name
  
  k_val <- 2
  k_values[i] <- k_val
  cat("  K value set to:", k_val, "\n")
  cat("  Resistance matrix path:", cd_path, "\n")
}


cat("\nProcessing null model:\n")
if (!file.exists(null_model_path)) {
  warning(paste("Null model matrix file does not exist, skipping ->", null_model_path))
} else {
  null_mat <- as.matrix(read.csv(null_model_path, header = FALSE))
  mat.list[[length(mat.list) + 1]] <- null_mat
  mod.names <- c(mod.names, "Null_Model_Goe")
  k_values <- c(k_values, 2)
  cat("  Null model matrix added, path:", null_model_path, "\n")
  cat("  Null model k value set to: 2\n")
}

valid_indices <- !sapply(mat.list, is.null) & !is.na(k_values)
mat.list <- mat.list[valid_indices]
k_values <- k_values[valid_indices]
mod.names <- mod.names[valid_indices]
n_valid <- length(mat.list)

if (n_valid == 0) {
  stop("No valid factor combinations available for analysis. Please check the configuration file and file paths.")
}
cat("\nFinal number of valid analysis combinations:", n_valid, "(including null model)\n")

k <- matrix(k_values, ncol = 1)
rownames(k) <- mod.names

genetic_df <- read_excel(genetic_xls_path)
genetic_mat <- as.matrix(genetic_df)
sites <- read.csv(sites_csv_path)
n_pop <- nrow(sites)
gd.response <- genetic_mat[lower.tri(genetic_mat)]
response <- matrix(0, n_pop, n_pop)
response[lower.tri(response)] <- gd.response

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
  cat("Created output directory:", output_dir, "\n")
}

cat("\nStarting Bootstrap analysis (1000 iterations)...\n")
cat("Number of models for analysis:", length(mat.list), "(including null model)\n")

AIC.boot <- Resist.boot(
  mod.names = mod.names, 
  dist.mat = mat.list,
  n.parameters = k[, 1],
  genetic.mat = response,
  obs = n_pop,
  sample.prop = 0.75,
  iters = 1000
)

saveRDS(AIC.boot, file.path(output_dir, "Bootstrap_Results_factors_plus_NullModel.rds"))
write.csv(AIC.boot, file.path(output_dir, "Bootstrap_Results_factors_plus_NullModel.csv"), row.names = FALSE)

cat("\n=== Bootstrap analysis completed for 63 factor combinations + null model ===\n")
cat("Number of models analyzed successfully:", n_valid, "\n")
cat("Results save path:", output_dir, "\n")
cat("Result files: Bootstrap_Results_factors_plus_NullModel.rds / Bootstrap_Results_factors_plus_NullModel.csv\n")

EOF