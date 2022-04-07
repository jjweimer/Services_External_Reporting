dataprep_monthly <- function(df){
  #create standardized monthly values 
  df$date <- paste(df$Q38,df$Q156,df$Q16, sep = "")
  rad_info_dates <- df$RecordedDate[df$Q2 %in% c("RAD","Info Desk")]
  df$date[df$Q2 %in% c("RAD","Info Desk")] <- substr(rad_info_dates,1,nchar(rad_info_dates)-5)
  df$date <- floor_date(mdy(df$date),"month")
  df$date <- as.character(df$date)
  return(df)
}