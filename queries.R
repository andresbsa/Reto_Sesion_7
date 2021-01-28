# Conexión a BDD shinydemo
library(DBI)
library(RMySQL)

BDD <- dbConnect(
  drv = RMySQL::MySQL(), # drivers
  dbname = "shinydemo",  # BDD
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com", # ruta al host
  username = "guest",    # usuario
  password = "guest")    # contraseña

# Una vez hecha la conexión a la BDD, generar una busqueda con dplyr que devuelva 
# el porcentaje de personas que hablan español en todos los países

dbListTables(BDD)
dbListFields(BDD, 'CountryLanguage')

C.Lang <- dbGetQuery(BDD, "select * from CountryLanguage")

library(dplyr)

pc.es <-  C.Lang %>% filter(Language == "Spanish")

# Realizar una gráfica con ggplot que represente este porcentaje de tal modo que 
# en el eje de las Y aparezca el país y en X el porcentaje, y que diferencíe entre 
# aquellos que es su lengua oficial y los que no con diferente color 
# (puedes utilizar la geom_bin2d() y coord_flip())

library(ggplot2)

pc.es %>%
  ggplot()+
  aes(x = CountryCode, y = Percentage, color = IsOfficial)+
  geom_bar(stat = "identity")+
  coord_flip()

# Una vez hecho esto hacer el commit y push para mandar tu archivo al repositorio 
# de Github Reto_Sesion_7

