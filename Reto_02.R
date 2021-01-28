# De la siguiente dirección donde se muestran los sueldos para Data Scientist
# (https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm),
# realiza las siguientes acciones:

# Extraer la tabla del HTML

library(rvest)

file <- read_html("https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm")
tables <- html_nodes(file, "table")
table1 <- html_table(tables[1], fill = TRUE)
table <- na.omit(as.data.frame(table1))

# Quitar los caracteres no necesarios de la columna sueldos 
# (todo lo que no sea número), para dejar solamente la cantidad mensual
# (La función gsub puede ser de utilidad)

table.num <- mutate(table, Sueldo = gsub("[^0-9]", "", table$Sueldo))

# Asignar ésta columna como tipo numérico para poder realizar operaciones con ella

table.num <- mutate(table.num, Sueldo = as.numeric(Sueldo))

# Ahora podrás responder esta pregunta ¿Cuál es la empresa que más paga y 
# la que menos paga?

table.num$Cargo[which.max(table.num$Sueldo)]
table.num$Cargo[which.min(table.num$Sueldo)]

# table.num %>%
#   arrange(desc(Sueldo))
