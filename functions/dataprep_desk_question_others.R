dataprep_desk_question_others <- function(df){
  #other desk questions
  foo <- df[!(is.na(df$date)),c("date","Q27","Q31")]
  foo$question_type <- paste(foo$Q27,foo$Q31, sep = "")
  foo <- foo[!(foo$question_type %in% c("Topical / Course Assignment Research","Research Help","")),] %>%
    group_by(date) %>% count(question_type) %>% 
    pivot_wider(names_from = question_type, values_from = n)
  foo[is.na(foo)] = 0
  return(foo)
}