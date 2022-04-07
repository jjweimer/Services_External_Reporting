dataprep_instruction_location <- function(df){
  # instruction location
  foo <- df[df$Q198_10_TEXT != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% count(Q198_10_TEXT) %>% 
    pivot_wider(names_from = Q198_10_TEXT, values_from = n)
  return(foo)
}