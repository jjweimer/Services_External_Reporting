dataprep_desk_question_type <- function(df){
  foo <- df[!(is.na(df$date)),c("date","Q27","Q31")]
  foo$question_type <- paste(foo$Q27,foo$Q31, sep = "")
  #research questions
  foo <- foo[foo$question_type %in% c("Topical / Course Assignment Research","Research Help"),] %>%
    group_by(date) %>% count(question_type) %>% 
    pivot_wider(names_from = question_type, values_from = n)
  foo$total_questions <- foo$`Research Help` + foo$`Topical / Course Assignment Research`
  return(foo)
}