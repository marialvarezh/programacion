getwd()
##practica 3- trabajando con datos climaticos 
##Autores: Daniel García Betancort y María Carmen Álvarez Hernández 
##Fecha: 17/03/2020 

##Directorio de trabajo####
getwd()
setwd()

##Instalamos las librerias necesarias con la función install.packages()####
##vamoms a utilizar la libreria envirem para ello
##se requiere instalar las librerias: sp, raster, palinsol y gsl
install.packages("sp")
install.packages("raster")
install.packages("palinsol")
install.packages("gsl")
install.packages("envirem")
install.packages("dplyr")
library(sp)
library(raster)
library(palinsol)
library(gsl)
library(envirem)
library(dplyr)


##Descargamos los datos de clima desde la pagina Chelsa 

##Datos con el modelo ACCESS####
##para poder abrir los archivos raster utilizamos la función raster

##escenario de 2041-2060; temperatura maxima; rcp85
TempJulio <- raster("datosclima\\CHELSA_tasmax_mon_ACCESS1-0_rcp85_r1i1p1_g025.nc_7_2041-2060_V1.2.tif") 
TempAgosto <- raster("datosclima\\CHELSA_tasmax_mon_ACCESS1-0_rcp85_r1i1p1_g025.nc_8_2041-2060_V1.2.tif")

##escenario de 2041-2060; precipitacion mensual; rcp85
PrecipJulio <- raster("datosclima\\CHELSA_pr_mon_ACCESS1-0_rcp85_r1i1p1_g025.nc_7_2041-2060.tif")
PrecipAgosto <- raster("datosclima\\CHELSA_pr_mon_ACCESS1-0_rcp85_r1i1p1_g025.nc_8_2041-2060.tif")

##NECESITAMOS VER COMO SE PONIAN TODAS LAS FUNCIONES EN UNA. NO ME ACUERDO 
class(TempJulio) 
class(TempAgosto)
class(PrecipJulio)
class(PrecipAgosto)

extent(TempJulio) ##extent da las coordenadas minimas y las maximas
extent(TempAgosto)
extent(PrecipJulio)
extent(PrecipAgosto)

ncell(TempJulio)#ncell da el numero total de celdas
ncell(TempAgosto)
ncell(PrecipJulio)
ncell(PrecipAgosto)

crs(TempJulio)#crs para ver el sistema de coordenadas 
crs(TempAgosto)
crs(PrecipJulio)
crs(PrecipAgosto)

plot(TempJulio)

##hacemos un clip de la zona de estudio con la funcion crop
tenerife <- as(extent(-16.78,-16.40,28,28.35), 'SpatialPolygons')##las coordenadas de la zona que quiero recortar 
recorte <- crop(TempJulio, tenerife) ##crop para recortar el raster 

plot(recorte) ##para visualizar la capa raster

writeRaster(recorte, filename="recorte.tif", format = "GTiff", overwrite=TRUE)

temperatura<-  hist(recorte, col= "red") ##visualizamos los datos en un histograma 

View(recorte)
src(recorte)
summary(recorte)
class(recorte)


##Datos con el modelo FIO-ESM####
##para poder abrir el archivo raster utilizamos la función raster

##escenario de 2041-2060; temperatura maxima; rcp85
TempJulioFIO <- raster("datosclima\\CHELSA_pr_mon_FIO-ESM_rcp85_r1i1p1_g025.nc_7_2041-2060.tif")
TempAgostoFIO <- raster("datosclima\\CHELSA_pr_mon_FIO-ESM_rcp85_r1i1p1_g025.nc_8_2041-2060.tif")

##escenario de 2041-2060; precipitacion mensual; rcp85
PrecipJulioFIO <- raster("datosclima\\CHELSA_tasmax_mon_FIO-ESM_rcp85_r1i1p1_g025.nc_8_2041-2060_V1.2 (1).tif")
PrecipAgostoFIO <- raster("datosclima\\CHELSA_tasmax_mon_FIO-ESM_rcp85_r1i1p1_g025.nc_8_2041-2060_V1.2.tif")

plot(PrecipAgostoFIO)
