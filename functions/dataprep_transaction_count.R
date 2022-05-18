dataprep_transaction_count <- function(df){
  # Transaction Count sums Q28 
  foo <- df[df$Q28 != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% 
    summarize(info_desk = sum(as.numeric(Q28)[!is.na(as.numeric(Q28))]))
  foo2 <- df[df$Q36 != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% 
    summarize(RAD = sum(as.numeric(Q36)[!is.na(as.numeric(Q36))]))
  obj <- full_join(foo, foo2, by = "date") 
  return(obj)
}