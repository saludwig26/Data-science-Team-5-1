
###################################################
### Vorbereitung der Umgebung ####

# Falls nicht installiert ggf. folgendes Paket ausführen
#install.packages("fastDummies")

# Umgebungsvariablen löschen
#remove(list = ls())

# Einbinden benötigter Funktionsbibliotheken
library(readr)
library(fastDummies)


###################################################
### Funktionsdefinitionen ####

#' Title Fast creation of normalized variables
#' Quickly create normalized columns from numeric type columns in the input data. This function is useful for statistical analysis when you want normalized columns rather than the actual columns.
#'
#' @param .data An object with the data set you want to make normalized columns from.
#' @param norm_values Dataframe of column names, means, and standard deviations that is used to create corresponding normalized variables from.
#'
#' @return A data.frame (or tibble or data.table, depending on input data type) with same number of rows an dcolumns as the inputted data, only with normalized columns for the variables indicated in the norm_values argument.
#' @export
#'
#' @examples
norm_cols <- function (.data, norm_values = NULL) {
  for (i in 1:nrow(norm_values)  ) {
    .data[[norm_values$name[i]]] <- (.data[[norm_values$name[i]]] - norm_values$mean[i]) / norm_values$sd[i]
  }
  return (.data)
}


#' Title Creation of a Dataframe including the Information to Standardize Variables
#' This function is meant to be used in combination with the function norm_cols
#'
#' @param .data A data set including the variables you want to get the means and standard deviations from.
#' @param select_columns A vector with a list of variable names for which you want to get the means and standard deviations from.
#'
#' @return A data.frame (or tibble or data.table, depending on input data type) including the names, means, and standard deviations of the variables included in the select_columns argument.
#' @export
#'
#' @examples
get.norm_values <- function (.data, select_columns = NULL) {
  result <- NULL
  for (col_name in select_columns) {
    mean <- mean(.data[[col_name]], na.rm = TRUE)
    sd <- sd(.data[[col_name]], na.rm = TRUE)
    result <- rbind (result, c(mean, sd))
  }
  result <- as.data.frame(result, stringsAsFactors = FALSE)
  result <- data.frame (select_columns, result, stringsAsFactors = FALSE)
  names(result) <- c("name", "mean", "sd")
  return (result)
}


###################################################
### Datenaufbereitung ####

# Booleans in 0 und 1 Umwandlung fur Neuronale Netzwerke


#Trenne das zu vorhersagende Datum wieder aus dem Datensatz
# vorhersage <- umsatzdaten[umsatzdaten$Datum==vorhersage_date, ]
# 
# umsatzdaten <- umsatzdaten %>%
#   filter(!Datum==vorhersage_date)


umwandlung_umsatzdaten  <- umsatzdaten  %>%
  mutate(holiday = ifelse(holiday == "TRUE", 1, 0)) %>%
  mutate(sylvester = ifelse(sylvester == "TRUE", 1, 0)) %>%
  mutate(dayoff_after = ifelse(dayoff_after == "TRUE", 1, 0)) %>%
  mutate(dayoff_b4 = ifelse(dayoff_b4 == "TRUE", 1, 0)) %>%
  mutate(VerlaengertesWE_Mo = ifelse(VerlaengertesWE_Mo == "TRUE", 1, 0)) %>%
  mutate(VerlaengertesWE_Fr = ifelse(VerlaengertesWE_Fr == "TRUE", 1, 0)) %>%
  mutate(schulferien = ifelse(schulferien == "TRUE", 1, 0)) %>%
  mutate(KielerWoche = ifelse(KielerWoche == "TRUE", 1, 0)) 
  umwandlung_umsatzdaten$monat <- as.numeric(umsatzdaten$monat)
  umwandlung_umsatzdaten$wochentag <- as.numeric(umsatzdaten$wochentag) 
  umwandlung_umsatzdaten$jahreszeit <- as.numeric(umsatzdaten$jahreszeit)
  # umwandlung_umsatzdaten$Temperatur <- as.numeric(umsatzdaten$Temperatur)
  # umwandlung_umsatzdaten$Windgeschwindigkeit <- as.numeric(umsatzdaten$Windgeschwindigkeit)
  # umwandlung_umsatzdaten$Wettercode <- as.numeric(umsatzdaten$Wettercode)
  # umwandlung_umsatzdaten$warmTemp <- as.numeric(umsatzdaten$warmTemp)
  # umwandlung_umsatzdaten$Temperatur_labels <- as.numeric(umsatzdaten$Temperatur_labels)



# Rekodierung von kategoriellen Variablen (zu Dummy-Variablen)
dummy_list <- c( "Warengruppe", "wochentag", "jahreszeit", "monat", "holiday", "sylvester", "dayoff_after", "dayoff_b4", "VerlaengertesWE_Mo", "VerlaengertesWE_Fr","schulferien", "KielerWoche") #, "Windgeschwindigkeit", "Wettercode", "Temp_abweichung", "warmTemp", "Temperatur_labels")

umsatzdaten_dummy = dummy_cols(umwandlung_umsatzdaten, dummy_list)

# Definition von Variablenlisten für die Dummies, um das Arbeiten mit diesen zu erleichtern
Warengruppe_dummies = c('Warengruppe_1', 'Warengruppe_2','Warengruppe_3', 'Warengruppe_4','Warengruppe_5','Warengruppe_6')
wochentag_dummies= c('wochentag_1', 'wochentag_2','wochentag_3', 'wochentag_4', 'wochentag_5','wochentag_6', 'wochentag_7') 
jahreszeit_dummies= c("jahreszeit_1", "jahreszeit_2", "jahreszeit_3", "jahreszeit_4")
monat_dummies= c("monat_1", "monat_2", "monat_3", "monat_4", "monat_5", "monat_6", "monat_7", "monat_8", "monat_9", "monat_10", "monat_11", "monat_12")
# Windgeschwindigkeit_dummies= c("Windgeschwindigkeit_1", "Windgeschwindigkeit_2", "Windgeschwindigkeit_3",  "Windgeschwindigkeit_NA" )
# Wettercode_dummies= c("Wettercode_1", "Wettercode_2", "Wettercode_NA")
# Temperatur_labels_dummies= c("Temperatur_labels_1", "Temperatur_labels_2" , "Temperatur_labels_3" , "Temperatur_labels_4" , "Temperatur_labels_5", "Temperatur_labels_NA")

# Standardisierung aller Feature Variablen und der Label Variable
norm_list <- c("Umsatz", "holiday", "sylvester","dayoff_after", "dayoff_b4", "VerlaengertesWE_Mo","VerlaengertesWE_Fr", "schulferien", "KielerWoche",  wochentag_dummies, jahreszeit_dummies, monat_dummies, Warengruppe_dummies) # Liste aller Variablen Windgeschwindigkeit_dummies, Wettercode_dummies, Temperatur_labels_dummies, "Bewoelkung", "Temperatur", "mean", "Temp_abweichung", "warmTemp",

norm_values_list <- get.norm_values(umsatzdaten_dummy, norm_list)    # Berechnung der Mittelwerte und Std.-Abw. der Variablen
umsatzdaten_norm <- norm_cols(umsatzdaten_dummy, norm_values_list) # Standardisierung der Variablen

###################################################
### Definition der Feature-Variablen und der Label-Variable ####

# Definition der Features (der unabhängigen Variablen auf deren Basis die Vorhersagen erzeugt werden sollen)
features = c( "Warengruppe_1" ,  wochentag_dummies, jahreszeit_dummies, "KielerWoche", "schulferien") #, monat_dummies, jahreszeit_dummies) 
# Definition der Label-Variable (der abhaengigen Variable, die vorhergesagt werden soll) sowie
label = 'Umsatz'

###################################################
### Definition von Trainings- und Testdatensatz ####

# Zufallszähler setzen, um die zufällige Partitionierung bei jedem Durchlauf gleich zu halten
set.seed(123)
# Bestimmung der Indizes des Traininsdatensatzes
train_ind <- sample(seq_len(nrow(umsatzdaten_norm)), size = floor(0.66 * nrow(umsatzdaten_norm)))

# Teilen in Trainings- und Testdatensatz
train_dataset = umsatzdaten_norm[train_ind, features]
test_dataset = umsatzdaten_norm[-train_ind, features]

# Selektion der Variable, die als Label definiert wurde
train_labels = umsatzdaten_norm[train_ind, label]
test_labels = umsatzdaten_norm[-train_ind, label]


