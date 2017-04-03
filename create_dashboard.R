source('downloading_data.R')
install.packages("install.load")
library(install.load)
load_package("DT","data.table","stringr")
list_of_markets <- c("TSLA", "NVDA", "AMD", "AAPL", "GE", "MU")
adatom <- prices(list_of_markets)#month-1, day, year


