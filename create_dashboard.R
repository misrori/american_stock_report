source('downloading_data.R')
#install.packages("install.load")
library(install.load)
load_package("DT","data.table","stringr", "plotly")
list_of_markets <- c("TSLA", "NVDA", "AMD", "AAPL", "GE", "MU", "OLED")
adatom <- prices(list_of_markets)#month-1, day, year
adatom$Date <- as.Date(adatom$Date)

my_days <- sort(unique(adatom$Date), decreasing = T)[c(1:20)]
adatom <- data.table(adatom[adatom$Date %in% my_days,])
setorder(adatom, ticker, Date)



my_df <- data.table()

for(i in list_of_markets){
  tmp_data <-adatom[ticker==i,]
  current <- tmp_data$Close[1]
  valtozasok <- c(0, (( tmp_data$Close[2:20]/current)-1)*100)
  #napok <-c('Today','1day before', '3 day before', '4 day before', '5 day before','10 day before','20 day before', '30 day before') 
  tmp_data$valtozasok <- valtozasok
  #tmp_data$my_days <- napok
  my_df <- rbind(my_df, tmp_data)

}

p<-plot_ly(my_df, x = ~Date, y = ~valtozasok, color =~ticker, text= ~Close)%>%
  add_lines()

p





