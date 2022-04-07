dataprep_digital_learning_objects <- function(df){
  #did you use any digital learning objects?
  foo <- df[df$Q193 != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% count(Q193) %>% 
    pivot_wider(names_from = Q193, values_from = n)
  return(foo)
}