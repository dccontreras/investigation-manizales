# Function to install and load required packages
install_and_load_packages <- function(package_list) {
  # Check which packages are not installed
  packages_to_install <- package_list[!(package_list %in% installed.packages()[,"Package"])]
  
  # Install packages that are not installed
  if (length(packages_to_install) > 0) {
    install.packages(packages_to_install, dependencies = TRUE)
  }
  
  # Load all packages
  lapply(package_list, library, character.only = TRUE)
  
  message("All packages are installed and loaded.")
}

# Example usage
required_packages <- c("dplyr", "ggplot2", "readxl", "tidyverse", "purrr")
install_and_load_packages(required_packages)
