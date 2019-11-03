library(gdata)
library(tools)
# Adds a file as a link followed by the file extension and size in kB in parenthesis.
add_file <- function(file_name, title) {
  #if(file.size(humanRefile_name) <= ){unit <- "MB"}else{unit <- "KB"}
  file_ext_size <- paste("[", title, "](", file_name, ") (", file_ext(file_name), ", ", humanReadable(file.size(file_name), standard="SI"), ")", sep ="")
  return(file_ext_size)
  }