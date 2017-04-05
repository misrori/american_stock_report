source('downloading_data.R')
install.packages("install.load")
library(install.load)
load_package("DT","data.table","stringr", "plotly")
list_of_markets <- c("TSLA", "NVDA", "AMD", "AAPL", "GE", "MU", "OLED")
adatom <- prices(list_of_markets)#month-1, day, year
adatom$Date <- as.Date(adatom$Date)

my_days <- sort(unique(adatom$Date), decreasing = T)[c(1:90)]
adatom <- data.table(adatom[adatom$Date %in% my_days,])
setorder(adatom, ticker, Date)
adat <- adatom[, valtozas:=(Close/shift(Close, 1L, type = "lag")-1)*100, by=ticker ]






f <- list(
  family = "Courier New, monospace",
  size = 18,
  color = "#7f7f7f"
)
x <- list(
  title = "Dátum",
  titlefont = f
)
y <- list(
  title = "Összeg",
  titlefont = f
)

a <- data.table(data_to_plot())
ab <- a[,.('osszeg'= sum(Ertek_KP_Millio)) , by=.(my_Date, Státusz)] 
setorder(ab, my_Date)
abc <- ab[, .(my_Date, osszegem = cumsum(osszeg) ), by= .(Státusz) ]

p<-plot_ly(adat, x = ~Date, y = ~Close, color =~ticker)%>%
  add_lines() #%>%layout(autosize = F, width = 1000, height = 800, margin = m, xaxis = x, yaxis = y )

p
