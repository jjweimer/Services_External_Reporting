dataprep_outreach_home_program <- function(df){
  #home program of outreach
  foo <- df[df$Q174!= "" & !(is.na(df$date)),] %>% 
    group_by(date) %>% count(Q174) %>%
    pivot_wider(names_from = Q174, values_from = n)
  return(foo)
}