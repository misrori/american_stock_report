library(stringr)
prices <- function(tickers, startDate=c("01", "01", "1900") ){
  ### define the URLs
  my_month <- ifelse(data.table::month(Sys.Date())-1<10,paste('0', data.table::month(Sys.Date())-1, sep=''), data.table::month(Sys.Date())-1)
  my_day <-str_split(as.character(Sys.Date()), '-')[[1]][3]
  my_year <- str_split(as.character(Sys.Date()), '-')[[1]][1]
  
  addstock_datas <- paste("http://real-chart.finance.yahoo.com/table.csv?s=",
                          tickers, "&a=", startDate[1], "&b=", startDate[2], "&c=", startDate[3],
                          "&d=", as.character(my_month), "&e=",as.character(my_day), "&f=",as.character(my_year),
                          "&g=d&ignore=.csv", sep="");
  
  ## using lapply instead of a loop: faster
  df <- lapply(seq(addstock_datas), function(x){temp <- read.csv(addstock_datas[x], stringsAsFactors = F);
  temp[] <- temp[nrow(temp):1,] 
  temp$ticker <- tickers[x];
  temp;})
  df <- do.call("rbind", df)
}
