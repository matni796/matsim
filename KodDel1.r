################################################################################
################################################################################
## DEL 1 - EVENT STUDIE ##
################################################################################
################################################################################


################################################################################
## LADDA OCH SPARA DATA ##
################################################################################
# Vi hämtar först workspace-filen "DataDel1.RData".
# Lättast är att öppna filen genom att klicka på den.
# Om man sparat ned den på t.ex "z:\\DataDel1.RData" så kan man 
# också direkt ladda in den med kommandot
load("z:\\DataDel1.RData")

# Det går också bra att öppna filen via menyn "Session\Load workspace".

# På samma sätt kan man spara filen via menyn "Session\Save workspace", eller med
save.image("z:\\DataDel1.RData")


################################################################################
## LADDA OCH SPARA R-KOD ##
################################################################################
# Denna fil heter "KodDel1.r".

# Inifrån R eller R-studio kan man öppna den via menyn "File\Open script"
# "File\Open file".
# Genom att t.ex. dra och släppa filen i Console-fönstret körs hela filen, men
# då öppnas den ej.

# Ett (bättre) alternativ till att öppna filen i R Editorn är att använda
# t.ex. Tinn-R eller R-studio editorn, eftersom man där har fler stödfunktioner.


################################################################################
## NÅGRA FÖRSTA EXEMPELKOMMANDON ##
################################################################################
# Vi börja med att definiera objektet "i" som ert gruppnummer.
?? -> i #GRUPPNUMMER - Ersätt ?? med ert gruppnummer

# Ni har nu skapat ert första objekt i R. Ni kan sedan t.ex. välja att
i # Titta på det.
i/5 # Dela det med 5
i*pi # ta de gånger pi
sqrt(i) # tag roten ur det
exp(i) # beräkna exponenten av det
log(i) # beräkna logaritmen av det
rep(i,4) # Upprepa det fyra gånger
rep(log(i),4) # Upprepa logaritmen av det fyra gånger
i -> j # Vi gör en kopia på objektet "i" och lägger denna i "j"
rm(i) # Ta bort objektet "i"
j -> i # Så fort vi matar in ett objekt igen, skrivs det gamla över
rm(j) # Vi tar sedan bort "j"
ls() # En lista på vilka objekt som finns.



################################################################################
## BESKRIVNING AV DATA ##
################################################################################
# Filen inluppgift.RData innehåller flera objekt. I denna del används
# "car" - Cumulative abnormal return (CAR) för N stycken företag (dimension 1) och N stycken grupper (dimension 2).
# "carvar" - Skattad varians för CAR för N stycken företag (dimension 1) och N stycken grupper (dimension 2).
# "comp" - Aktiekurs för 72 dagar (dimension 1) och N stycken grupper (dimension 2)
# "market" - Marknadsindex som matchar aktiekurserna i "comp" vid samma tidsperiod


# Visa "comp" för samtliga grupper
comp

# Visa dimensionen av comp
dim(comp)

# Visa "comp" i ett separat redigerbart fönster
fix(comp)

# Varje grupp kommer bara att använda sig av den i:te kolumnen i samtliga fyra objekt. 
# I "car" och "carvar" saknas värden längs diagonalen ("NA" betyder not available).
# Ni behöver därför själva beräkna fram det i:te saknade värdet i "car" och "carvar"
# med hjälp av de i:te kolumnerna i "comp" och "market.

# Vi börjar med att ta ut grupp i:s dataserier
COMP <- comp[,i] # Spara grupp i:s "comp" i "COMP"
MARK <- market[,i] # Spara grupp i:s "market" i "MARK"
CAR <- car[,i] # Spara grupp i:s "car" i "CAR"
CARVAR <- carvar[,i] # Spara grupp i:s "carvar" i "CARVAR"

# Visa "COMP" direkt på skärmen
COMP

# Spara längden av "COMP" i objektet "NCOMP"
NCOMP <- length(COMP) # Antal värden i "NCOMP"

# Vad är...
COMP[1] # först värdet av "COMP"
COMP[10] # tionde värdet av "COMP"
COMP[1:10] # de tio första värdena av "COMP"
COMP[9:10] # nionde och tionde värdena av "COMP"
COMP[NCOMP] # sista värdet av "COMP"
COMP[c(1,5,7,NCOMP)] # första, femte, sjunde och sista värdet av "COMP"
COMP/COMP[NCOMP] # "COMP"-serien delat med dess sista värde



################################################################################
## BERÄKNA AVKASTNINGSMÅTT, GRUNDLÄGGANDE STATISTISKA FUNKTIONER SAMT PLOTTAR ##
################################################################################
# Beräkna ränteintensitet på samma sätt som i del 1
RCOMP <- log( COMP[2:NCOMP] / COMP[1:(NCOMP-1)] ) # ränteintensitet för det i:te företaget
RMARK <- log( MARK[2:NCOMP] / MARK[1:(NCOMP-1)] ) # ränteintensitet för matchande index


# Några grundläggande statistikfunktioner applicerade på RCOMP (och ibland RMARK)
length(RCOMP) #Kontrollera längden av RCOMP
mean(RCOMP) # medelvärde
median(RCOMP) # median
quantile(RCOMP) # kvantil
sum(RCOMP) # summa
var(RCOMP) # varians
sd(RCOMP) # standardavvikelse
cor(RCOMP) # korrelation, varför funkar inte detta?
var(RCOMP,RMARK) # kovarians 
cor(RCOMP,RMARK) # korrelation

?cor # Är man osäker på en funktion kan man få hjälp genom att skriva ? framför

example(cor) # Man kan också få exempel på funktionen


# Några grundläggande univariata plottar av RCOMP
plot(RCOMP) # Plot av RCOMP efter ordning
ts.plot(RCOMP) # Plot av RCOMP som tidsserie
hist(RCOMP) # Histogram av RCOMP
boxplot(RCOMP) # Boxplot av RCOMP 
barplot(RCOMP) # Stapeldiagram


# Sätt samman RCOMP och RMARK till en matris med två kolumner
# (Byt ut cbind mot rbind för rader istället)
Rmatris <- cbind(RCOMP,RMARK)
colMeans(Rmatris) # kolumnmedel
colSums(Rmatris) # kolumnsummor
rowMeans(Rmatris) # radmedel
rowSums(Rmatris) # radsummor
var(Rmatris) # variansmatris
cor(Rmatris) # korrelationsmatris


# Några grundläggande plottar av RCOMP OCH RMARK. Obs, resultatet är inte alltid
# samma som att plotta Rmatris. Detta pga att (plot-)funktionerna är generiska.

# Spridningsdiagram
par(mfrow=c(1,2))
plot(RCOMP,RMARK)
plot(Rmatris)

# Histogram
par(mfrow=c(2,2))
hist(RCOMP); hist(RMARK)
hist(Rmatris)

# Boxplot
par(mfrow=c(1,2))
boxplot(RCOMP,RMARK)
boxplot(Rmatris)

# Tidsserie
par(mfrow=c(1,2))
plot(RCOMP,type="l",col=1); lines(RMARK,col=2) # Här lägger vi också till färg
ts.plot(Rmatris,col=1:2) # Här lägger vi också till färg



################################################################################
# 1.2 MARKNADSMODELLEN #
################################################################################
# Skatta en linjär regressionsmodellen genom funktionen "lm", där y (företag) 
# och x (marknad) är ränteintensiteter. Vi skattar denna för de första 60 
# avkastningarna, (dvs baserat på 61 av de 72 dagarna).

# ange antal avkastningar
60 -> N

# Spara ned skattningen av markandsmodellen i objektet "model".
model <- lm(RCOMP[1:N] ~ RMARK[1:N])

# Se på objektet, en kort sammanfattning med skattade koefficienter ges
model 

# Längre sammanfattning, däribland skattade koefficienter + p-värden
summary(model) 

# Anova tablån
anova(model) 

# Är man osäker vad objektet "model" är kan man kolla dess klass
class(model)

# Vi kan också ta fram enskilda delar m.h.a. [vald del] (totalt 12 stycken)
model[1] # visade sig vara parameterskattningarna
model[2] # visade sig vara residualerna
model[5] # visade sig vara skattade värden

# Vet man vad delen heter går det också bra att skriva "$vald_del"
modelres <- model$residuals # spara residualerna från regressionsmodellen
modelfit <- model$fitted.values # spara skattade värden från regressionsmodellen
ahat <- model$coefficients[1] # spara ned alfaskattning från regressionen
bhat <- model$coefficients[2] # spara ned betaskattning från regressionen

# Vi kan tänka oss en portfölj bestående endast av Rcomp och sedan beräkna uppskattad risk
tot <- var(RCOMP[1:N]) # Beräkna och spara "total risk"
sys <- bhat^2*var(RMARK[1:N]) # Beräkna och spara "systematisk risk"
spe <- var(modelres) # Beräkna och spara "specifik risk"
  
  

# Nedanstående kod plottar stegvis 2x3-plottar för residualerna från marknadsmodellen
dev.off() # Stäng ned tidigare fönster om sådant finns, annars ges ett felmeddelande
par(mfcol=c(2,3),cex=1.2,mar=c(5,4,4,2)) # Öppna ett fönster med 2x3 plottar
# Fördelningsplott
modelhist <- hist(modelres,plot=F) # Spara ett histogram över residualerna i "modelhist"
hist(modelres,prob=T,col="gray",xlim=quantile(modelhist$mids)[c(1,5)]*1.2,ylim=c(0,max(modelhist$density))*1.2,
  main="Fördelning utan ordning",xlab="Residual",ylab="Andel") # Histogram
lines(density(modelres),col=4,lwd=2) # Lägg till täthetsskattningen (som ett utjämnat histogram) med blå färg. Bilden borde då bli tydligare.
x <- seq(min(modelres)*1.5,max(modelres)*1.5,length=1000) # Beräkna x-koordinater till en normalfördelningskurva
y <- dnorm(x,mean=mean(modelres),sd=sd(modelres)) # Beräkna y-koordinater till en normalfördelningskurva
lines(x,y,col=2,lwd=2) # Lägg till normalfördelningskurvan med röd färg
legend("topright",c("'Histogram'","Täthet","Normal"),col=c("Gray","Blue","Red"),pch=15,cex=1.2,bty="n") # Lägg till förklaring
# QQ-plot
qqnorm(modelres,main="QQ-plot normalfördelning",xlab="Teoretiska kvantiler",ylab="Kvantiler enligt data"); qqline(modelres) # Normal probability
# Residualer mot skattade värden
plot(modelres,modelfit,main="Skattade värden mot residualer",xlab="Skattade värden",ylab="Residualer")
# Ordnad plot
plot(modelres,type="b",main="Ordnade residualer",xlab="Ordning av residualer",ylab="Residual");abline(0,0) 
# Lag plot
plot(modelres[2:N],modelres[1:(N-1)],main="Lag plot med regressionslinje",xlab="Residual tidpunkt t",ylab="Residual tidpunkt t-1")
abline(lm(modelres[1:(N-1)]~modelres[2:N]),col=2);
legend("topleft",legend=paste("R2=",format(round(cor(modelres[1:(N-1)],modelres[2:N])^2,3),nsmall=3),sep=""),bty="n")
# Korrelogram
acf(modelres,main="Korrelogram för residualer",xlab="Antal laggar",ylab="Korrelation",ci=.95)


# Om vi vill kunna använda några av ovanstående plottar enkelt vid senare 
# tillfälle så kan man definiera en ny funktion med ett modelobjekt med
# möjlighet att välja ordning, antal rader, samt kolumner. Kalla funktionen för
# resplot(modellobjekt,plottar i ordning,antal rader,antal kolumner) 
resplot <- function (modelobjekt,plottval,antalrader,antalkolumner) { # början av funktionen
  a1 <- as.numeric(residuals(modelobjekt)); a2 <- as.numeric(fitted.values(modelobjekt)); a3 <- length(a1)
  par(mfcol=c(antalrader,antalkolumner),cex=1.2,mar=c(5,4,4,2)) # Gör 2x2 plottar
  for (a4 in 1:length(plottval)) {
    if (plottval[a4]==1) { # Fördelningsplott
    a5 <- hist(a1,plot=F) # Spara ett histogram över residualerna i "a5"
    hist(a1,prob=T,col="gray",xlim=quantile(a5$mids)[c(1,5)]*1.2,ylim=c(0,max(a5$density))*1.2,
      main="Fördelning utan ordning",xlab="Residual",ylab="Andel") # Histogram
    lines(density(a1),col=4,lwd=2) # Lägg till täthetsskattningen (som ett utjämnat histogram) med blå färg. Bilden borde då bli tydligare.
    x <- seq(min(a1)*1.5,max(a1)*1.5,length=1000) # Beräkna x-koordinater till en normalfördelningskurva
    y <- dnorm(x,mean=mean(a1),sd=sd(a1)) # Beräkna y-koordinater till en normalfördelningskurva
    lines(x,y,col=2,lwd=2) # Lägg till normalfördelningskurvan med röd färg
    legend("top",c("'Histogram'","Täthet","Normal"),col=c("Gray","Blue","Red"),pch=15,cex=1.2,bty="n") # Lägg till förklaring
    }; if (plottval[a4]==2) { # QQ-plot
    qqnorm(a1,main="QQ-plot normalfördelning",xlab="Teoretiska kvantiler",ylab="Kvantiler enligt data"); qqline(a1) # Normal probability
    }; if (plottval[a4]==3) { # Residualer mot skattade värden
    plot(a1,a2,main="Skattade värden mot residualer",xlab="Skattade värden",ylab="Residualer")
    }; if (plottval[a4]==4) { # Ordnad plot
    plot(a1,type="b",main="Ordnade residualer",xlab="Ordning av residualer",ylab="Residual");abline(0,0) 
    }; if (plottval[a4]==5) { # Lag plot
    plot(a1[2:a3],a1[1:(a3-1)],main="Lag plot med regressionslinje",xlab="Residual tidpunkt t",ylab="Residual tidpunkt t-1")
    abline(lm(a1[1:(a3-1)]~a1[2:a3]),col=2);
    legend("top",legend=paste("R2=",format(round(cor(a1[1:(a3-1)],a1[2:a3])^2,3),nsmall=3),sep=""),bty="n")
    }; if (plottval[a4]==6) { # Korrelogram
    acf(a1,main="Korrelogram för residualer",xlab="Antal laggar",ylab="Korrelation",ci=.95)
} } }# slut på funktionen

# I denna kan vi välja valfri ordning för de 6 plottarna:
#1=Fördelningsplott; #2=QQ-plot; #3=Residualer mot skattade värden 
#4=Ordnad plot; #5=Lag plot; #6=Korrelogram
# Vill vi ha första och sista plotten på en rad och två kolumner skriver vi; 
resplot(model, c(1,6), 1, 2)


################################################################################
# 1.3 ABNORMAL RETURNS #
################################################################################
# beräkna abnormal return för det i:te företaget de 11 sista dagarna
ARi <- RCOMP[(N+1):71] - ( ahat + bhat*RMARK[(N+1):71] ) 

# Beräkna varians för abnormal returns
myM <- mean(RMARK[1:N]) # Genomsnittlig marknadsavkastning för estimationsperioden
kvot <- (RMARK[(N+1):71]-myM)^2 / sum((RMARK[1:N]-myM)^2 ) # Kvotuttrycket inom den stora parentesen
varARi <- sum(model$res^2)/(N-2) * (1 + 1/N + kvot) # Skattad varians för AR(I)

# Beräkna prediktionsintervall för abnormal returns
piu95 <- qt(.975,N-2)*varARi^.5
pil95 <- qt(.025,N-2)*varARi^.5
piu80 <- qt(.9,N-2)*varARi^.5
pil80 <- qt(.1,N-2)*varARi^.5


# Plot av abnormal returns inklusive prediktionsintervall
dev.off() # Stäng ned tidigare fönster om sådant finns, annars ges ett felmeddelande
par(mfrow=c(1,1),cex=1.2,mar=c(5,4,4,2)) # Ange formatet för plotten
yl <- quantile(c(ARi,piu95,pil95))[c(1,5)]*1.2 # Bestäm y-gränserna för figuren
plot(ARi,main="Daglig AR samt prediktionsintervall för i:te företaget", # Här börjar vi plotta men
  axes=F,xlab="Tidpunkt",ylab="Abnormal return",ylim=yl,pch=15,xlim=c(1,13),col=6) # väljer först bort skalorna
axis(1,1:11,-5:5,las=2); axis(2); box() # Vi lägger till egna skalor samt ritar en box
lines(1:11,rep(0,11),lwd=2) # lägg till förväntad avvikande avkastning
lines(1:11,piu95,col=2,lty=2,lwd=3,pch=17) # lägg till övre gräns 95% pred int
lines(1:11,pil95,col=2,lty=2,lwd=3,pch=17) # lägg till undre gräns 95% pred in
lines(1:11,piu80,col=4,lty=2,lwd=3,pch=17) # lägg till övre gräns 95% pred int
lines(1:11,pil80,col=4,lty=2,lwd=3,pch=17) # lägg till undre gräns 95% pred in
legend("topright",legend=c("Actual return","Model return","80% pred int","95% pred int"),
  bty="o",col=c(6,1,4,2),pch=15,cex=1.3)

# Sätt in beräknat CAR där det saknas, dvs för företag i
CAR[i] <- sum(ARi) # cumulative abnormal return för grupp i sparas i CAR

# Spara medelvärdet av CAR i objektet CAR_
CAR_ <- mean(CAR) 
CAR_

# Sätt in CARVAR där det saknas, dvs för företag i 
CARVAR[i] <- sum(varARi) # Skattad varians för företag (och gruppnummer) i:s CAR, sparas i CARVAR[på position i]
CARVAR

# Spara skattade variansen medelvärdet av CAR i objektet CAR_var
CAR_var <- 1/length(CAR)^2*sum(CARVAR) 
CAR_var



# Ibland kan man vilja använda sig av någon av de kända statistiska fördelningarna
??Distributions # Kolla paketet Distributions

# Vad är t-värdet som används vid dubbelsidigt 95% konfidensintervall om vi har t.ex. 30 frihetsgrader?
qt(p=.975, df=30) # Övre t-värde
qt(p=.025, df=30) # Undre t-värde

# Vad är z-värdet som används vid dubbelsidigt 95% konfidensintervall?
qnorm(.975) # Övre z-värde
qnorm(.025) # Nedre z-värde

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  