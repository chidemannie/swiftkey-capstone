library(stringi)
library(stringr)
library(data.table)

set.seed(2026)

# --- Load data paths ---
base_dir <- "data_raw/final/en_US"

files <- c(
  blogs   = file.path(base_dir, "en_US.blogs.txt"),
  news    = file.path(base_dir, "en_US.news.txt"),
  twitter = file.path(base_dir, "en_US.twitter.txt")
)

# --- Sampling function ---
read_sample_lines <- function(path, p = 0.05) {
  con <- file(path, open = "r", encoding = "UTF-8")
  on.exit(close(con), add = TRUE)
  
  lines <- readLines(con, warn = FALSE)
  lines[runif(length(lines)) < p]
}

# --- Cleaning ---
clean_text <- function(x) {
  x <- stri_trans_tolower(x)
  x <- str_replace_all(x, "http[s]?://\\S+|www\\.\\S+", " ")
  x <- str_replace_all(x, "[^a-z\\s']", " ")
  x <- str_replace_all(x, "\\s+", " ")
  x <- str_trim(x)
  x[nchar(x) > 0]
}

# --- Load + clean ---
raw <- unlist(lapply(files, read_sample_lines), use.names = FALSE)
cleaned <- clean_text(raw)

# --- Tokenization ---
make_ngrams <- function(lines, n) {
  tokens <- str_split(lines, "\\s+")
  grams <- vector("list", length(tokens))
  
  for (i in seq_along(tokens)) {
    w <- tokens[[i]]
    if (length(w) < n) next
    idx <- seq_len(length(w) - n + 1)
    grams[[i]] <- vapply(idx, function(j)
      paste(w[j:(j + n - 1)], collapse = " "), character(1))
  }
  
  unlist(grams, use.names = FALSE)
}

# --- Build n-grams ---
bigram  <- data.table(ngram = make_ngrams(cleaned, 2))[, .N, by = ngram]
trigram <- data.table(ngram = make_ngrams(cleaned, 3))[, .N, by = ngram]
fourgram<- data.table(ngram = make_ngrams(cleaned, 4))[, .N, by = ngram]

# --- Remove rare ---
bigram  <- bigram[N >= 2]
trigram <- trigram[N >= 2]
fourgram<- fourgram[N >= 2]

# --- Save ---
saveRDS(bigram,  "bigram.rds")
saveRDS(trigram, "trigram.rds")
saveRDS(fourgram,"fourgram.rds")


