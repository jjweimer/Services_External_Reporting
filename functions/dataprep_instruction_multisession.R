dataprep_instruction_multisession <- function(df){
  foo <- df[df$Q191 != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% 
    count(Q191) %>% 
    pivot_wider(names_from = Q191, values_from = n)
  colnames(foo) <- c("date","single_session","multi_session")
  foo[is.na(foo)] <- 0
  return(foo)
}