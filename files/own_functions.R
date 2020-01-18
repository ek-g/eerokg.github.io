# Adds a file as a link followed by the file extension, page count (if PDF) and size in kB in parenthesis:
library(gdata)
library(tools)
library(pdftools)

add_file <- function(file_name, title, font_size = 2) {
  paste("[", title, "](", file_name, ") <font size=", font_size, ">(", toupper(file_ext(file_name)), ", ",
        if(file_ext(file_name) == "pdf"){
        ifelse(pdf_info(file_name)[2] == 1, paste(pdf_info(file_name)[2], "Seite, "), paste(pdf_info(file_name)[2], "Seiten, "))},
        humanReadable(file.size(file_name), standard="SI"), ")</font>", sep ="")
  }