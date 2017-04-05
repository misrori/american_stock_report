source('my_functions.R')
#install.packages("install.load")
library(install.load)
load_package("DT","data.table","stringr", "plotly")
list_of_markets <- c("TSLA", "NVDA", "AMD", "AAPL", "GE", "MU", "OLED")
adatom_teljes <- prices(list_of_markets)#month-1, day, year
adatom_teljes$Date <- as.Date(adatom_teljes$Date)


tozsde_plot(number_of_days = 20, my_adatom = adatom_teljes)
tozsde_plot(number_of_days = 30, my_adatom = adatom_teljes)
tozsde_plot(number_of_days = 50, my_adatom = adatom_teljes)
tozsde_plot(number_of_days = 5, my_adatom = adatom_teljes)
