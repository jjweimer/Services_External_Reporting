dataprep_outreach_audience <- function(df){
  #status of outreach audience
  foo <- df[df$Q194 != "" & !(is.na(df$date)),] %>% 
    group_by(date) %>% count(Q194) %>%
    pivot_wider(names_from = Q194, values_from = n)
  return(foo)
}