library(data.table)
library(stringr)

bigram  <- readRDS("bigram.rds")
trigram <- readRDS("trigram.rds")
fourgram<- readRDS("fourgram.rds")

predict_next <- function(text, top_n = 3) {
  
  text <- tolower(text)
  text <- str_replace_all(text, "[^a-z\\s']", " ")
  text <- str_trim(text)
  
  words <- unlist(str_split(text, "\\s+"))
  len <- length(words)
  
  if (len >= 3) {
    prefix <- paste(tail(words, 3), collapse = " ")
    match <- fourgram[grepl(paste0("^", prefix, " "), ngram)]
    if (nrow(match) > 0) {
      return(head(sub(paste0(prefix, " "), "", match$ngram[order(-match$N)]), top_n))
    }
  }
  
  if (len >= 2) {
    prefix <- paste(tail(words, 2), collapse = " ")
    match <- trigram[grepl(paste0("^", prefix, " "), ngram)]
    if (nrow(match) > 0) {
      return(head(sub(paste0(prefix, " "), "", match$ngram[order(-match$N)]), top_n))
    }
  }
  
  if (len >= 1) {
    prefix <- tail(words, 1)
    match <- bigram[grepl(paste0("^", prefix, " "), ngram)]
    if (nrow(match) > 0) {
      return(head(sub(paste0(prefix, " "), "", match$ngram[order(-match$N)]), top_n))
    }
  }
  
  return("the")
}
