dataprep_instruction_attendees <- function(df){
  #total instruction attendees Q21
  foo <- df[df$Q21 != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% summarise(attendees = sum(as.numeric(Q21)))
  return(foo)
}