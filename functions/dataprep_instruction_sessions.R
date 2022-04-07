dataprep_instruction_sessions <- function(df){
  #how many in person instruction sessions? Q197_1 IN person sessions
  in_person <- df[df$Q197_1 != "" & !(is.na(df$date)),] %>%
    group_by(date) %>%
    summarise(in_person_sessions = sum(as.numeric(Q197_1)))
  # how many online instruction sessions ? Q1971_2 online sessions
  online <- df[df$Q197_2 != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% summarise(online_sessions = sum(as.numeric(Q197_2)))
  #join 
  foo <- full_join(in_person, online, by = "date")
  foo$total_sessions <- foo$in_person_sessions + foo$online_sessions
  return(foo)
}