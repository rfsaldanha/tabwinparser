parse_cnv <- function(file){
  
}

file <- "systems/CNV/RACACOR.CNV"

res <- readr::read_fwf(
  # Read CNV file with positions
  file = file,
  skip = 1,
  col_positions = readr::fwf_positions(
    start = c(1, 5, 10, 61),
    end = c(3, 9, 60, 80),
    col_names = c("sub", "seq", "label", "cod")
  ),
  col_types = "cccc",
  locale = locale(encoding = "latin1")
) %>%
  # Expand rows where cod have commas
  group_by(row_number()) %>%
  tidyr::expand(cod = strsplit(x = cod, split = ",")[[1]], tidyr::nesting(sub, seq, label)) %>%
  ungroup() %>%
  relocate(cod, .after = label) %>%
  # Create sequencies where cod have dash...
  #mutate(cod = paste(seq(from = strsplit(x = cod, split = "-")[[1]][1], to = strsplit(x = cod, split = "-")[[1]][length(strsplit(x = cod, split = "-")[[1]])]), collapse = ",")) %>%
  group_by(row_number()) %>%
  mutate(cod = ifelse(test = str_detect(string = cod, pattern = "-"), yes = paste(seq(from = strsplit(x = teste, split = "-")[[1]][1], to = strsplit(x = teste, split = "-")[[1]][length(strsplit(x = teste, split = "-")[[1]])]), collapse = ","), no = cod)) %>%
  ungroup() %>%
  # ... and expand rows where cod have commas again
  group_by(row_number()) %>%
  tidyr::expand(cod = strsplit(x = cod, split = ",")[[1]], tidyr::nesting(sub, seq, label)) %>%
  ungroup() %>%
  relocate(cod, .after = label) %>%
  # Remove artifical row number
  select(-1)
  

mutate(cod = ifelse(str_detect(string = cod, pattern = "-"), "tem -", "nao tem -"))


teste <- "00-99"

paste(seq(from = strsplit(x = teste, split = "-")[[1]][1], to = strsplit(x = teste, split = "-")[[1]][length(strsplit(x = teste, split = "-")[[1]])]), collapse = ",")

