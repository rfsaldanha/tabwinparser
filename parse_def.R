parse_def <- function(file){
  paste0(
    # Append headder
    "name,variable,rule,ref_file\r\n", 
    # Read DEF file with encoding
    readr::read_file(
      file = file, 
      locale = locale(encoding = "latin1")
    )
  ) %>%
    # Read delimited text
    readr::read_delim(
      col_names = TRUE,
      delim = ",", 
      comment = ";",
      col_types = "cccc"
    ) %>%
    # Remove first two rows 
    tail(-2) %>%
    # Create column type
    dplyr::mutate(
      type = substr(name, 1, 1),
      name = substr(name, 2, 1000),
    ) %>%
    dplyr::relocate(type, .before = name) %>%
    # Squish columns
    dplyr::mutate(across(.cols = dplyr::everything(), .fns = stringr::str_squish)) %>%
    # Remove duplicated
    dplyr::group_by(name) %>%
    dplyr::filter(type != "C" & type != "S") %>%
    dplyr::ungroup()
}