library(tidyverse)
library(tidytext)


source("parse_def.R")
source("parse_cnv.R")

##### Testes DEF #####

def <- parse_def(file = "systems/RD2008.DEF")

def_variables <- unique(def$variable)

for(def_var in def_variables){
  message(def_var)
  
  type <- def[which(def$variable == def_var), "type"]
  name <- def[which(def$variable == def_var), "name"]
  variable <- def[which(def$variable == def_var), "variable"]
  rule <- def[which(def$variable == def_var), "rule"]
  ref_file <- def[which(def$variable == def_var), "ref_file"]
}



##### Testes CNV #####

res <- parse_cnv(file = "systems/CNV/UF.CNV")
