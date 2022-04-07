dataprep_outreach_collaborators <- function(df){
  #home program of outreach collaborators
  foo <- df[df$Q174_8_TEXT!= "" & !(is.na(df$date)),] %>% 
    group_by(date) %>% count(Q174_8_TEXT)
  return(foo)
}