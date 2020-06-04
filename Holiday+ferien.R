###HOLIDAYS###
#Einbinden der Bibliotheken
library(RQuantLib)

#Zeige deutsche Feiertage an:
getHolidayList("Germany", as.Date("2013-01-01"), as.Date("2023-01-01"))

#Füge die fehlenden Feiertage manuell hinzu
further_holidays <- (as.Date(c(
  "2013-10-03", "2014-10-03", "2015-10-03", "2016-10-03", "2017-10-03",
  "2018-10-03", "2019-10-03", "2020-10-03", "2021-10-03", 
  "2022-10-03", "2017-10-31", "2018-10-31", "2019-10-31", "2020-10-31",
  "2021-10-31", "2022-10-31", "2013-05-09", "2014-05-29", "2015-05-14",
  "2016-05-05", "2017-05-25", "2018-05-10", "2019-05-30", "2020-05-21",
  "2021-05-13", "2022-05-26", "2013-05-20", "2014-06-09", "2015-05-25",
  "2016-05-16", "2017-06-05", "2018-05-21", "2019-06-10", "2020-06-01",
  "2021-05-24", "2022-06-06", "2016-05-01", "2016-12-24", "2016-12-25",
  "2016-12-31", "2017-01-01", "2017-12-24", "2017-12-31",
  "2015-12-26", "2020-12-26", "2021-05-01", "2021-12-25", "2021-12-26",
  "2022-01-01", "2022-05-01", "2022-12-24", "2022-12-25", "2022-12-31")))

#Schreibe tibble mit allen Feiertagen:
Holiday_List <- tibble(Datum = c(
  getHolidayList("Germany", as.Date("2013-01-01"), as.Date("2023-01-01")),
  further_holidays))

#Bereite Tabelle für Export vor:
Holiday_List$Datum <- sort(Holiday_List$Datum)
Holiday_List$holiday <- TRUE

#Export als CSV:
write.csv(Holiday_List,"Holiday_List", row.names = F)




###FERIEN###
#detach("package:RQuantLib", unload = TRUE)
library(timeDate)

#Daten der Schulferien in Schleswig-Holstein im Zeitraum der Umsatzdatentabelle
schulferien <- tibble(Datum = as.Date(c( 
  timeSequence(as.Date("2013-07-01"), as.Date("2013-08-03")),
  timeSequence(as.Date("2013-10-04"), as.Date("2013-10-18")),
  timeSequence(as.Date("2013-12-23"), as.Date("2014-01-06")),
  timeSequence(as.Date("2014-04-16"), as.Date("2014-05-02")),
  timeSequence(as.Date("2014-07-14"), as.Date("2014-08-23")),
  timeSequence(as.Date("2014-10-13"), as.Date("2014-10-25")),
  timeSequence(as.Date("2014-12-22"), as.Date("2015-01-06")),
                                         
  timeSequence(as.Date("2015-03-24"), as.Date("2015-04-09")),
  timeSequence(as.Date("2015-07-25"), as.Date("2015-09-03")),
  timeSequence(as.Date("2015-10-17"), as.Date("2015-10-29")),
  timeSequence(as.Date("2015-12-23"), as.Date("2016-01-06")),
  timeSequence(as.Date("2016-04-16"), as.Date("2016-05-02")),
  timeSequence(as.Date("2016-07-14"), as.Date("2016-08-23")),
  timeSequence(as.Date("2016-10-13"), as.Date("2016-10-25")),
  timeSequence(as.Date("2016-12-22"), as.Date("2017-01-06")),
                                         
  timeSequence(as.Date("2017-04-07"), as.Date("2017-04-21")),
  timeSequence(as.Date("2017-07-24"), as.Date("2017-09-02")),
  timeSequence(as.Date("2017-10-16"), as.Date("2017-10-27")),
  timeSequence(as.Date("2017-12-21"), as.Date("2018-01-06")),
  timeSequence(as.Date("2018-03-29"), as.Date("2018-04-13")),
  timeSequence(as.Date("2018-07-09"), as.Date("2018-08-18")),
  timeSequence(as.Date("2018-10-01"), as.Date("2018-10-19")),
  timeSequence(as.Date("2018-12-21"), as.Date("2019-01-04")),
  
  timeSequence(as.Date("2019-04-04"), as.Date("2019-04-18")),
  timeSequence(as.Date("2019-07-01"), as.Date("2019-08-10")),
  timeSequence(as.Date("2019-10-04"), as.Date("2019-10-18")),
  timeSequence(as.Date("2019-12-23"), as.Date("2020-01-06")),
  timeSequence(as.Date("2020-03-30"), as.Date("2020-04-17")),
  timeSequence(as.Date("2020-06-29"), as.Date("2020-08-08")),
  timeSequence(as.Date("2020-10-05"), as.Date("2020-10-17")),
  timeSequence(as.Date("2020-12-21"), as.Date("2021-01-06")),
  
  timeSequence(as.Date("2021-04-01"), as.Date("2021-04-16")),
  timeSequence(as.Date("2021-06-21"), as.Date("2021-07-31")),
  timeSequence(as.Date("2021-10-04"), as.Date("2021-10-16")),
  timeSequence(as.Date("2021-12-23"), as.Date("2022-01-08")),
  timeSequence(as.Date("2022-04-04"), as.Date("2022-04-16")),
  timeSequence(as.Date("2022-07-04"), as.Date("2022-08-13")),
  timeSequence(as.Date("2022-10-10"), as.Date("2022-10-21")),
  timeSequence(as.Date("2022-12-23"), as.Date("2023-01-07"))
)))

schulferien$schulferien <- TRUE
# umsatzdaten <- left_join(umsatzdaten, schulferien)
# umsatzdaten$schulferien <- !is.na(umsatzdaten$schulferien)


#Export als CSV:
write.csv(schulferien,"Schulferien", row.names = F)
