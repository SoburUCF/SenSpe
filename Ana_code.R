# Import the packages

library(dplyr)
library(stringr)
library(tidyr)

# Read your file

df <- read.csv("data/MPN_VIPR_GR.csv", stringsAsFactors = FALSE)
# Columns should be: IDs, Organism, Position_F, Position_R, Position_Probe


extract_start <- function(x) {
  as.numeric(str_extract(x, "\\d+"))
}

df2 <- df %>%
  mutate(genome = ifelse(!is.na(IDs) & IDs != "", IDs, NA)) %>%
  fill(genome, .direction = "down") %>%
  mutate(
    F_start = extract_start(Position_F),
    R_start = extract_start(Position_R),
    Probe_start = extract_start(Position_Probe)
  )

F_tbl <- df2 %>%
  filter(!is.na(F_start)) %>%
  distinct(genome, F_start)

R_tbl <- df2 %>%
  filter(!is.na(R_start)) %>%
  distinct(genome, R_start)

P_tbl <- df2 %>%
  filter(!is.na(Probe_start)) %>%
  distinct(genome, Probe_start)

max_amplicon <- 200   # change to 300 if needed

hits <- F_tbl %>%
  inner_join(R_tbl, by = "genome", relationship = "many-to-many") %>%
  filter(
    F_start < R_start,
    R_start - F_start + 1 <= max_amplicon
  ) %>%
  inner_join(P_tbl, by = "genome", relationship = "many-to-many") %>%
  filter(
    Probe_start > F_start,
    Probe_start < R_start
  ) %>%
  mutate(
    amplicon_size = R_start - F_start + 1
  ) %>%
  distinct(genome, F_start, R_start, Probe_start, .keep_all = TRUE)

hit_counts <- hits %>%
  group_by(genome) %>%
  summarise(
    complete_hits = n(),
    .groups = "drop"
  )

hit_counts
