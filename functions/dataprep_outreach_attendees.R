dataprep_outreach_attendees <- function(df){
  #aggregate outreach attendees by month
  df$Q184 <- as.numeric(df$Q184)
  foo <- df %>% group_by(date) %>%
    summarize(outreach_attendees = sum(Q184[!is.na(Q184)]))
  return(foo)
}