rm(list = ls())
current_dir <- getwd()
# Codes and paths
codes <- c("02", "03", "04", "05")
years <- c("18", "19")
bases <- c("entrada", "salida")

for(year in years) {
  iteration <- "01"
  for (base in bases) {
    for (code in codes) {
      # Dynamically create path and dataframe name
      df_name <- paste0("EGRA", code, "_MZ_",year,iteration)
      
      # 
      save_data_path <- paste0(current_dir,"/01_data/01_rawdata/Manizales/20", 
                               year,"/", base, "/EGRA", code, "_MZ_", year, 
                               iteration,".RData")
      # Load the .RData file into a temporary environment
      loaded_var_name <- load(save_data_path)
      
      # Extract the name of the loaded variable
      loaded_var_name <- ls(temp_env)[1]  # Assuming only one object in .RData
      
      # Assign the loaded data to the dynamically generated name in the global environment
      assign(df_name, get(loaded_var_name), envir = .GlobalEnv)
    }
    iteration <- "02"
  }
}



# Rename variables --------------------------------------------------------


# Import the Excel file
# Assumes the first sheet and first row as column names


  dataframes <- list("EGRA02_MZ_1801", "EGRA03_MZ_1801", "EGRA04_MZ_1801", "EGRA05_MZ_1801") # Add all your dataframe names here as strings
  
  # Loop through each dataframe name
  for (df_name in dataframes) {
    # Access dataframe using get()
    df <- get(df_name)
    
    # Sonido de las letras
    df <- rename_variables(df, "^sonido_letras_", "CSL_")
    df <- rename_variables(df, "^Total Sonido letras", "CSL_total")
    
    # Palabras inventadas
    df <- rename_variables(df, "^palabras_inventadas_", "DPSS_")
    df <- rename_variables(df, "^Total palabras inventadas", "DPSS_total")
    
    # Lectura de palabras sin sentido
    df <- rename_variables(df, "^lectura_pasaje_", "LP_")
    df <- rename_variables(df, "^Total lectura pasaje", "LP_total")
    
    df <- rename_variables(df, 
                                       "^Total comprension", 
                                       "CL_total")
    df <- rename_variables(df, 
                           "^Total Comprension", 
                           "CL_total")
    
    
    # General vars
    df <- rename_variables(df, 
                                       "^Jornada...8", 
                                       "Jornada")
    
    df <- rename_variables(df, 
                                       "^Gnero", 
                                       "Genero")
    
      # Comprension de lectura
      # Define the columns to rename
      if (df_name == "EGRA02_MZ_1801"){
        old_columns <- c(
          "Que_se_pusieron_a_jugar_la_gallina_y_el_cinepies",
          "A_donde_fueron_a_jugar_futbol", 
          "Quien_fue_mas_rapido",
          "Quien_pateo_mas_lejos",
          "Quien_anot_un_solo_gol"
        )
      } else if (df_name == "EGRA03_MZ_1801"){
        old_columns <- c(
          "Que_tomaba_el_abuelo",
          "Como_se_llamaba_el_pueblo", 
          "A_qu_ayudaba_el_abuelo_cuando_era_nio",
          "En_qu_se_convierte_la_semilla_cuando_crece",
          "De_qu_color_es_el_fruto_que_da_el_Cafeto",
          "Que_se_hace_primero_Secar_el_caf_o_Tostarlo_y_molerlo",
          "Personaje_principal",
          "realidad"
        )
      } else if (df_name == "EGRA04_MZ_1801"){
        old_columns <- c(
          "Qu_les_gusta_jugar_a_Pedro_y_a_Mateo", 
          "Cmo_se_forman_los_grupos_para_jugar_ftbol",
          "Cmo_se_siente_el_recreo_cuando_juegan_pelota", 
          "En_qu_momento_les_gusta_jugar_ftbol_a_Pedro_y_a_Mateo", 
          "Quien_lleva_el_baln_para_jugar_el_partido", 
          "Por_que_no_fue_Miguel_a_la_escuela", 
          "Por_que_penso_Pedro_que_el_recreo_seria_aburrido",
          "Cual_fue_la_idea_brillante_de_Mateo"
        )
      } else if (df_name == "EGRA05_MZ_1801"){
        old_columns <- c(
          "Qu_les_gusta_jugar_a_Pedro_y_a_Mateo", 
          "Quien_lleva_el_baln_para_jugar_el_partido", 
          "Por_que_no_fue_Miguel_a_la_escuela", 
          "Por_que_penso_Pedro_que_el_recreo_seria_aburrido", 
          "Cual_fue_la_idea_brillante_de_Mateo"
        )
      }
      
      
      # Apply the renaming function with prefix "CL_1"
      df <- rename_columns_sequential(df, 
                                                  old_columns, 
                                                  "CL_1")
      names(df)[names(df) == 
                              "Numero_de_Identificacion_del_Estudiante"] <- "ID_Student"
      
      start_index <- match("CL_total", names(df))
      
      # # Remove variables
      df <- df[, 1:(start_index)]
      
    # Assign back to global environment
    assign(df_name, df)
    
    save_data_path <- paste0(getwd(), 
                             "/01_data/03_finaldata/Manizales/2018/entrada/",df_name, ".RData")
    save(df_name, 
         file = save_data_path, 
         compress = TRUE)
  }
  
###############################################################################
###############################################################################

dataframes <- list("EGRA02_MZ_1802", "EGRA03_MZ_1802", "EGRA04_MZ_1802", "EGRA05_MZ_1802") # Add all your dataframe names here as strings

# Loop through each dataframe name
for (df_name in dataframes) {
  # Access dataframe using get()
  df <- get(df_name)
  
  colnames(df) <- gsub("\\(|\\)", "", colnames(df))
  
  # # Sonido de las letras
  df <- rename_variables(df, "^Sonido de las letras ", "CSL_")
  # df <- rename_variables(df, "^Total Sonido letras", "CSL_total")
  # 
  # # Palabras inventadas
  df <- rename_variables(df, "^Decodificación de palabras sin sentido ", "DPSS_")
  # df <- rename_variables(df, "^Total palabras inventadas", "DPSS_total")
  # 
  # # Lectura de palabras sin sentido
  df <- rename_variables(df, "^Lectura de un Pasaje ", "LP_")

  # Comprension de lectura
  # Define the columns to rename
  if (df_name == "EGRA02_MZ_1802"){
    
    old_columns <- c(
      "¿Qué se pusieron a jugar la gallina y el cimepiés?\r\n[Fútbol]", 
      "¿A dónde fueron a jugar fútbol?\r\n[a la cancha]", 
      "¿Quién fue más rápido? [el ciempiés]", 
      "¿Quién pateó más lejos? [El ciempiés]",
      "¿Quién anotó un solo gol? [la gallina]"
    )
    
    max_cl_question <- "CL_1_5"
    
    start_col_csl <- which(names(df) == "CSL_M")
    end_col_csl <- which(names(df) == "CSL_E...95")
    
    start_col_lp <- which(names(df) == "LP_La...162")
    end_col_lp <- which(names(df) == "LP_hijo.")
    
    
  } else if (df_name == "EGRA03_MZ_1802"){
    old_columns <- c(
      "¿Qué tomaba el abuelo?\r\n[Café]", 
      "¿Cómo se llamaba el pueblo?\r\n[Neira]", 
      "¿A qué ayudaba el abuelo cuando era niño?  [A sembrar café]", 
      "¿En qué se convierte la semilla cuando crece? [En cafeto]", 
      "¿De qué color es el fruto que da el cafeto? [Rojo]", 
      "Qué se hace primero: Secar el café o tostarlo y molerlo [Secar el Café]", 
      "¿Quién es el personaje principal de la historia? [El abuelo]", 
      "¿Crees que esta historia podría suceder en la realidad?" 
    )
    max_cl_question <- "CL_1_8"
    
    start_col_csl <- which(names(df) == "CSL_M")
    end_col_csl <- which(names(df) == "CSL_E...95")
    
    start_col_lp <- which(names(df) == "LP_El...162")
    end_col_lp <- which(names(df) == "LP_mundo.")
    
  } else if (df_name == "EGRA04_MZ_1802"){
    old_columns <- c(
      "Qué les gusta jugar a Pedro y a Mateo\r\n [Fútbol/Jugar pelota]", 
      "¿Cómo se forman los grupos para jugar fútbol?\r\n[por grado/por afinidad/por grado o por afinidad]", 
      "¿Cómo se siente el recreo cuando juegan pelota? Se siente cortico", 
      "¿En qué momento les gusta jugar fútbol a Pedro y a Mateo?  [a la hora del recreo]", 
      "¿Quién lleva el balón para jugar el partido? [Miguel]", 
      "¿Por qué no fue Miguel a la escuela?  [porque tenía varicela]", 
      "¿Por qué pensó Pedro que el recreo sería aburrido? [Porque no habría partido]", 
      "¿Cuál fue la idea brillante de Mateo? [Buscar hojas de papel usadas/buscar papel usado]"
    )
    max_cl_question <- "CL_1_8"
    
    start_col_csl <- which(names(df) == "CSL_M")
    end_col_csl <- which(names(df) == "CSL_E...93")
    
    start_col_lp <- which(names(df) == "LP_Pedro...160")
    end_col_lp <- which(names(df) == "LP_Miguel.")
    
  } else if (df_name == "EGRA05_MZ_1802"){
    old_columns <- c(
      "Qué les gusta jugar a Pedro y a Mateo\r\n [Fútbol/Jugar pelota]", 
      "¿Cómo se forman los grupos para jugar fútbol?\r\n[por grado/por afinidad/por grado o por afinidad]", 
      "¿Cómo se siente el recreo cuando juegan pelota? Se siente cortico", 
      "¿En qué momento les gusta jugar fútbol a Pedro y a Mateo?  [a la hora del recreo]", 
      "¿Quién lleva el balón para jugar el partido? [Miguel]", 
      "¿Por qué no fue Miguel a la escuela?  [porque tenía varicela]", 
      "¿Por qué pensó Pedro que el recreo sería aburrido? [Porque no habría partido]", 
      "¿Cuál fue la idea brillante de Mateo? [Buscar hojas de papel usadas/buscar papel usado]"
    )
    max_cl_question <- "CL_1_8"
    
    start_col_csl <- which(names(df) == "CSL_M")
    end_col_csl <- which(names(df) == "CSL_E...93")
    
    start_col_lp <- which(names(df) == "LP_Pedro...101")
    end_col_lp <- which(names(df) == "LP_Miguel.")
  }
  start_col_dpss <- which(names(df) == "DPSS_lete")
  end_col_dpss <- which(names(df) == "DPSS_duba")
  
  # rename variables
  column_names_csl <- names(df)[start_col_csl:end_col_csl]
  df <- rename_columns_sequential(df,
                                  column_names_csl,
                                  "CSL_")
  
  column_names_dpss <- names(df)[start_col_dpss:end_col_dpss]
  df <- rename_columns_sequential(df,
                                  column_names_dpss,
                                  "DPSS_")
  
  column_names_lp <- names(df)[start_col_lp:end_col_lp]
  df <- rename_columns_sequential(df,
                                  column_names_lp,
                                  "LP_")
  # Apply the renaming function with prefix "CL_1"
  df <- rename_columns_sequential(df,
                                  old_columns,
                                  "CL_1")
  names(df)[names(df) ==
              "Numero_de_Identificacion_del_Estudiante"] <- "ID_Student"

  start_index <- match(max_cl_question, names(df))

  # Remove variables
  df <- df[, 1:(start_index)]

  # Assign back to global environment
  assign(df_name, df)

  save_data_path <- paste0(getwd(),
                           "/01_data/03_finaldata/Manizales/2018/salida/",df_name, ".RData")
  save(df_name,
       file = save_data_path,
       compress = TRUE)
}



