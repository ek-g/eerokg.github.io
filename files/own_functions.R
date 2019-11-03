# Adds a file as a link followed by the file extension, page count (if PDF) and size in kB in parenthesis:

library(gdata)
library(tools)
library(pdftools)

add_file <- function(file_name, title) {
  paste("[", title, "](", file_name, ") (", toupper(file_ext(file_name)), ", ",
        if(file_ext(file_name) == "pdf"){
        paste(pdf_info(file_name)[2], "Seiten, ")},
        humanReadable(file.size(file_name), standard="SI"), ")", sep ="")
  }