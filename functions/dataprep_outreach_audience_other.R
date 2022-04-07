dataprep_outreach_audience_other <- function(df){
  #outreach audience other text
  foo <- df[df$Q194_6_TEXT != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% count(Q194_6_TEXT)
  return(foo)
}