studien <- bib2df("/Users/eerokuusisto/git/kuusisto_de/files/testbib.bib")

cites <- sapply(seq_len(nrow(studien)),
                function(i){oc_coci_cites(studien$DOI[i])}