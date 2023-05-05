# R script to load packages required by separate quarto files / sections

# set a seed for reproducibility
set.seed(567)


# default packages
default_packages <- c("dplyr", # data manipulation
                      "tidyr", # data manipulation
                      "RColorBrewer", # colours
                      "naniar", # missing data
                      "flextable", # table production
                      "ggplot2", # data visualisation, plotting
                      "GGally",  # data visualisation
                      "knitr",  # report production
                      "corrplot", # correlation
                      "ggcorrplot", # correlation
                      "ade4", # EDA
                      "factoextra", # PCA, visualisation
                      "cowplot", # plotting
                      "patchwork", # plotting
                      "psych", # statistics, PCA
                      "paran", # parallel analysis
                      "dendextend", # dendrograms
                      "cluster" # clustering
                      ) 

# assign packages based on file name, set at beginning of each quarto file
packages <- default_packages

if (file == "dim_red") {
  packages <- c("dplyr", "flextable", "psych", "paran", "ade4", "factoextra", "patchwork")
  
} else if (file == "EDA") {
  packages <- c("dplyr", "flextable", "RColorBrewer", "ggplot2", "GGally", "ggcorrplot", "corrplot", "cowplot", "psych", "patchwork")
  
} else if (file == "data") {
  packages <- c("dplyr", "flextable", "RColorBrewer", "naniar")
  
} else if (file == "intro") {
  packages <- c("flextable","RColorBrewer")
  
} else {
  packages
}
 
# set repo url
cran_repo <- "https://www.stats.bris.ac.uk/R/"

# install and load packages
for (package in packages) {
  if (!require(package, character.only = TRUE)) {
    if (package == "citr") {
      devtools::install_github("crsh/citr")
    } else {
      install.packages(package, repos = cran_repo)
    }
    library(package, character.only = TRUE)
  }
}

# flextable defaults
set_flextable_defaults(
  font.family = "Helvetica",
  font.size = 12, 
  font.color = "#333333",
  border.color = "navy",
  background.color = "white",
  table.layout = "fixed",
  theme_fun = theme_vanilla,
  padding.top = 5, padding.bottom = 5,
  padding.left = 6, padding.right = 6,
  na_str = "NA", 
  digits = 3
)

# set_flextable_defaults(
#   font.family = "Arial",
#   font.size = 10, 
#   font.color = "#616161",
#   border.color = "gray", 
#   background.color = "#C2D2CA",
#   table.layout= "autofit",
#   theme_fun = theme_vanilla,
#   padding.top = 3, padding.bottom = 3,
#   padding.left = 4, padding.right = 4,
#   na_str = "<na>", 
#   digits = 2
# )




#font.color = "#333333",
#border.color = "gray", 
#background.color = "#FAFAFA",
# A3C4BC colour in plots