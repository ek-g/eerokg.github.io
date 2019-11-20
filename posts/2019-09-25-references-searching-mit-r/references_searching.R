## Copyright 2019 Eero Kuusisto-Gussmann - CC BY 4.0

# Pakete bei Bedarf installieren:
# install.packages(c("citecorp", "bib2df", "tidyverse")

# Für das Herunterladen der Zitierangaben:
library(citecorp)
# Um BibTeX-Dateien zu importieren:
library(bib2df)
# Für weitere Bearbeitung und Darstellung der Daten:
library(tidyverse)

studien <- bib2df("~/git/R-Projekte/kuusisto_de/files/testbib.bib")

# Inhalt des data frames anzeigen:
studien

# Die DOIs:
studien$DOI

cites <- sapply(seq_len(nrow(studien)),
                function(i){oc_coci_cites(studien$DOI[i])}
)

# Das Ergebnis ist eine Liste von data frames, binden wir sie zusammen:
cites <- bind_rows(cites)

# Generierte Daten anschauen:
cites

refs <- sapply(seq_len(nrow(studien)),
               function(i){oc_coci_refs(studien$DOI[i])}
)
refs <- bind_rows(refs)
refs

# Erst führen wie die DOIs beider Objekte zusammen:
cites_u_refs <- tibble(doi = c(cites$citing, refs$cited))

# Schauen wir uns die Daten an:
cites_u_refs

# ...und entfernen DOIs, wenn mehrfach vorkommen:
cites_u_refs <- cites_u_refs[!duplicated(cites_u_refs$doi),]

# Jetzt sollen wir einige Zeilen weniger haben:
cites_u_refs

# Für die Dokumentation:
write_csv(cites, "cites.csv", quote = FALSE)
write_csv(refs, "refs.csv", quote = FALSE)

# Für das Importieren in Literaturverwaltungsprogramm:
write(cites_u_refs$doi, "cites_u_refs.txt")

# Nicht erschrecken: das kann kann sogar einige Minuten dauern:
metadata <- oc_coci_meta(studien$DOI)

# Schauen wir die Daten an:
metadata

# Nur einige relevante Spalten wg. Lesbarkeit auswählen:
metadata %>% select(author, year, title, reference, citation)

# Filtern wir daraus nur die, bei denen etwas fehlt:
manual <- metadata %>%
  filter(reference == "" | citation == "") %>%
  # Eine neue Spalte, die uns die fehlende "Richtung" sagt:
  mutate(missing = if_else(reference == "" & citation == "", "both",
                           if_else(reference == "", "backward", "forward"))) %>%
  # Für bessere Lesbarkeit:
  select(Missing = missing, Author = author, Year = year, Title = title,
         Journal = source_title, Vol. = volume, DOI = doi)

# Daten anschauen:
manual

# Export in eine csv-Tabelle:
write_csv(manual, "manual.csv", quote = FALSE)