# Print a message indicating the start of the initialization
#!/bin/bash

# Print a message indicating the start of the initialization
echo "Starting initialization..."

# Install the necessary R packages
R -e 'if(!require("pak"))install.packages("pak")'
R -e '
packages <- c(
  "reticulate",
  "testthat",
  "dplyr",
  "ggplot2",
  "stac",
  "yaml",
  "arrow",
  "rstac",
  "tibble",
  "tidyverse",
  "data.table",
  "janitor",
  "pracma",
  "broom",
  "EnvStats",
  "patchwork",
  "rnaturalearth",
  "zoo"
)

pak::pkg_install(packages)