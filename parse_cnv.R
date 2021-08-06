parse_cnv <- function(file){
  
}

file <- "systems/CNV/UF.CNV"

res <- readr::read_fwf(
  file = file,
  skip = 1,
  col_positions = readr::fwf_positions(
    start = c(1, 5, 10, 61),
    end = c(3, 9, 60, 80),
    col_names = c("A", "B", "C", "D")
  ),
  col_types = "cccc",
  locale = locale(encoding = "latin1")
)
