dataprep_instructor_program <- function(df){
  #home program of instructor and co-instructor
  foo <- df[df$Q14 != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% count(Q14) %>%
    pivot_wider(names_from = Q14, values_from = n) 
  return(foo)
}