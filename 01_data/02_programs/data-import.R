# Load the required library
current_dir <- getwd()
source(file.path(current_dir, "src/install-packages.R"))
source(file.path(current_dir, "src/custom-functions.R"))



# Import data -------------------------------------------------------------



# Codes and paths
codes <- c("02", "03", "04", "05")
years <- c("18", "19", "20", "21", "22", "23", "24")
bases <- c("entrada", "salida")
# Loop through codes to read data and assign to dataframe
for(year in years) {
  iteration <- "01"
  for (base in bases) {
    for (code in codes) {
      # Dynamically create path and dataframe name
      file_path <- paste0(current_dir,"/01_data/01_rawdata/Manizales/20",
                          year,"/",base, "/EGRA", code, "_MZ_", year, 
                          iteration,".xlsx")
      df_name <- paste0("EGRA", code, "_MZ_",year,iteration)
      
      # Read Excel file using the path from your list
      df <- read_excel(file_path, sheet = 1, col_names = TRUE)
      
      # Assign dataframe to the name dynamically
      assign(df_name, df)
      
      # 
      save_data_path <- paste0(current_dir,"/01_data/01_rawdata/Manizales/20", 
                               year,"/", base, "/EGRA", code, "_MZ_", year, 
                               iteration,".RData")
      save(df_name,
           file = save_data_path,
           compress = TRUE)
    }
    iteration <- "02"
  }
}
