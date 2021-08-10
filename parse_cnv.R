parse_cnv <- function(file){
  
}

file <- "systems/CNV/MICROBR.CNV"

res <- readr::read_fwf(
  # Read CNV file with positions
  file = file,
  skip = 1,
  col_positions = readr::fwf_positions(
    start = c(1, 4, 10, 61),
    end = c(3, 9, 60, 1000),
    col_names = c("sub", "seq", "label", "cod")
  ),
  col_types = "cccc",
  locale = readr::locale(encoding = "latin1")
) %>%
  # Expand rows where cod have commas
  group_by(row_number()) %>%
  tidyr::expand(cod = strsplit(x = cod, split = ",")[[1]], tidyr::nesting(sub, seq, label)) %>%
  dplyr::ungroup() %>%
  dplyr::relocate(cod, .after = label) %>%
  # Create sequencies where cod have dash...
  dplyr::group_by(row_number()) %>%
  dplyr::mutate(from_dash = ifelse(test = str_detect(string = cod, pattern = "-"), yes = TRUE, no = FALSE)) %>%
  dplyr::mutate(cod = ifelse(test = str_detect(string = cod, pattern = "-"), yes = paste(seq(from = strsplit(x = cod, split = "-")[[1]][1], to = strsplit(x = cod, split = "-")[[1]][length(strsplit(x = cod, split = "-")[[1]])]), collapse = ","), no = cod)) %>%
  dplyr::ungroup() %>%
  # ... and expand again rows where cod have commas
  dplyr::group_by(row_number()) %>%
  tidyr::expand(cod = strsplit(x = cod, split = ",")[[1]], tidyr::nesting(sub, seq, label, from_dash)) %>%
  dplyr::ungroup() %>%
  dplyr::relocate(cod, .after = label) %>%
  # Remove possible conflicts
  dplyr::group_by(cod) %>%
  dplyr::mutate(freq = n()) %>%
  dplyr::filter(!(from_dash == TRUE & freq >= 2)) %>%
  dplyr::ungroup() %>%
  # Remove helpers
  dplyr::select(-1, -sub, -from_dash, -freq) %>%
  # Remove lines with NA
  na.omit() %>%
  # Convert cod to numeric
  dplyr::mutate(cod = as.numeric(cod))
  

mutate(cod = ifelse(str_detect(string = cod, pattern = "-"), "tem -", "nao tem -"))


teste <- "00-99"

paste(seq(from = strsplit(x = teste, split = "-")[[1]][1], to = strsplit(x = teste, split = "-")[[1]][length(strsplit(x = teste, split = "-")[[1]])]), collapse = ",")

