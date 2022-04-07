dataprep_instructor_program_other <- function(df){
  #home program of instructor and co-instructor other text
  foo <- df[df$Q14_10_TEXT != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% count(Q14_10_TEXT) %>%
    pivot_wider(names_from = Q14_10_TEXT, values_from = n) 
  return(foo)
}