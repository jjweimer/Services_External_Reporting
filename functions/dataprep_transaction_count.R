dataprep_transaction_count <- function(df){
  # Transaction Count sums Q28 
  foo <- df[df$Q28 != "" & !(is.na(df$date)),] %>%
    group_by(date) %>% 
    summarize(transaction_count = sum(as.numeric(Q28)[!is.na(as.numeric(Q28))]))
  return(foo)
}