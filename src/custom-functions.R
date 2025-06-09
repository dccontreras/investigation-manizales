# General function to rename variables based on pattern replacement
rename_variables <- function(df, old_name, new_name) {
  names(df) <- gsub(old_name, new_name, names(df))
  return(df)
}


# Function to rename selected columns in sequence with a pattern
rename_columns_sequential <- function(df, old_names, prefix) {
  # Find the positions of the columns to rename
  col_indices <- which(names(df) %in% old_names)
  
  # Generate new names with the provided prefix and sequence
  new_names <- paste0(prefix, "_", seq_along(col_indices))
  
  # Assign the new names to the selected columns
  names(df)[col_indices] <- new_names
  
  return(df)
}
