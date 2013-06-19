################################################################################
################################################################################
## DEL 1 - EVENT STUDIE ##
################################################################################
################################################################################


################################################################################
## LADDA OCH SPARA DATA ##
################################################################################
# Vi h�mtar f�rst workspace-filen "DataDel1.RData".
# L�ttast �r att �ppna filen genom att klicka p� den.
# Om man sparat ned den p� t.ex "z:\\DataDel1.RData" s� kan man 
# ocks� direkt ladda in den med kommandot
load("z:\\DataDel1.RData")

# Det g�r ocks� bra att �ppna filen via menyn "Session\Load workspace".

# P� samma s�tt kan man spara filen via menyn "Session\Save workspace", eller med
save.image("z:\\DataDel1.RData")


################################################################################
## LADDA OCH SPARA R-KOD ##
################################################################################
# Denna fil heter "KodDel1.r".

# Inifr�n R eller R-studio kan man �ppna den via menyn "File\Open script"
# "File\Open file".
# Genom att t.ex. dra och sl�ppa filen i Console-f�nstret k�rs hela filen, men
# d� �ppnas den ej.

# Ett (b�ttre) alternativ till att �ppna filen i R Editorn �r att anv�nda
# t.ex. Tinn-R eller R-studio editorn, eftersom man d�r har fler st�dfunktioner.


################################################################################
## N�GRA F�RSTA EXEMPELKOMMANDON ##
################################################################################
# Vi b�rja med att definiera objektet "i" som ert gruppnummer.
?? -> i #GRUPPNUMMER - Ers�tt ?? med ert gruppnummer

# Ni har nu skapat ert f�rsta objekt i R. Ni kan sedan t.ex. v�lja att
i # Titta p� det.
i/5 # Dela det med 5
i*pi # ta de g�nger pi
sqrt(i) # tag roten ur det
exp(i) # ber�kna exponenten av det
log(i) # ber�kna logaritmen av det
rep(i,4) # Upprepa det fyra g�nger
rep(log(i),4) # Upprepa logaritmen av det fyra g�nger
i -> j # Vi g�r en kopia p� objektet "i" och l�gger denna i "j"
rm(i) # Ta bort objektet "i"
j -> i # S� fort vi matar in ett objekt igen, skrivs det gamla �ver
rm(j) # Vi tar sedan bort "j"
ls() # En lista p� vilka objekt som finns.



################################################################################
## BESKRIVNING AV DATA ##
################################################################################
# Filen inluppgift.RData inneh�ller flera objekt. I denna del anv�nds
# "car" - Cumulative abnormal return (CAR) f�r N stycken f�retag (dimension 1) och N stycken grupper (dimension 2).
# "carvar" - Skattad varians f�r CAR f�r N stycken f�retag (dimension 1) och N stycken grupper (dimension 2).
# "comp" - Aktiekurs f�r 72 dagar (dimension 1) och N stycken grupper (dimension 2)
# "market" - Marknadsindex som matchar aktiekurserna i "comp" vid samma tidsperiod


# Visa "comp" f�r samtliga grupper
comp

# Visa dimensionen av comp
dim(comp)

# Visa "comp" i ett separat redigerbart f�nster
fix(comp)

# Varje grupp kommer bara att anv�nda sig av den i:te kolumnen i samtliga fyra objekt. 
# I "car" och "carvar" saknas v�rden l�ngs diagonalen ("NA" betyder not available).
# Ni beh�ver d�rf�r sj�lva ber�kna fram det i:te saknade v�rdet i "car" och "carvar"
# med hj�lp av de i:te kolumnerna i "comp" och "market.

# Vi b�rjar med att ta ut grupp i:s dataserier
COMP <- comp[,i] # Spara grupp i:s "comp" i "COMP"
MARK <- market[,i] # Spara grupp i:s "market" i "MARK"
CAR <- car[,i] # Spara grupp i:s "car" i "CAR"
CARVAR <- carvar[,i] # Spara grupp i:s "carvar" i "CARVAR"

# Visa "COMP" direkt p� sk�rmen
COMP

# Spara l�ngden av "COMP" i objektet "NCOMP"
NCOMP <- length(COMP) # Antal v�rden i "NCOMP"

# Vad �r...
COMP[1] # f�rst v�rdet av "COMP"
COMP[10] # tionde v�rdet av "COMP"
COMP[1:10] # de tio f�rsta v�rdena av "COMP"
COMP[9:10] # nionde och tionde v�rdena av "COMP"
COMP[NCOMP] # sista v�rdet av "COMP"
COMP[c(1,5,7,NCOMP)] # f�rsta, femte, sjunde och sista v�rdet av "COMP"
COMP/COMP[NCOMP] # "COMP"-serien delat med dess sista v�rde



################################################################################
## BER�KNA AVKASTNINGSM�TT, GRUNDL�GGANDE STATISTISKA FUNKTIONER SAMT PLOTTAR ##
################################################################################
# Ber�kna r�nteintensitet p� samma s�tt som i del 1
RCOMP <- log( COMP[2:NCOMP] / COMP[1:(NCOMP-1)] ) # r�nteintensitet f�r det i:te f�retaget
RMARK <- log( MARK[2:NCOMP] / MARK[1:(NCOMP-1)] ) # r�nteintensitet f�r matchande index


# N�gra grundl�ggande statistikfunktioner applicerade p� RCOMP (och ibland RMARK)
length(RCOMP) #Kontrollera l�ngden av RCOMP
mean(RCOMP) # medelv�rde
median(RCOMP) # median
quantile(RCOMP) # kvantil
sum(RCOMP) # summa
var(RCOMP) # varians
sd(RCOMP) # standardavvikelse
cor(RCOMP) # korrelation, varf�r funkar inte detta?
var(RCOMP,RMARK) # kovarians 
cor(RCOMP,RMARK) # korrelation

?cor # �r man os�ker p� en funktion kan man f� hj�lp genom att skriva ? framf�r

example(cor) # Man kan ocks� f� exempel p� funktionen


# N�gra grundl�ggande univariata plottar av RCOMP
plot(RCOMP) # Plot av RCOMP efter ordning
ts.plot(RCOMP) # Plot av RCOMP som tidsserie
hist(RCOMP) # Histogram av RCOMP
boxplot(RCOMP) # Boxplot av RCOMP 
barplot(RCOMP) # Stapeldiagram


# S�tt samman RCOMP och RMARK till en matris med tv� kolumner
# (Byt ut cbind mot rbind f�r rader ist�llet)
Rmatris <- cbind(RCOMP,RMARK)
colMeans(Rmatris) # kolumnmedel
colSums(Rmatris) # kolumnsummor
rowMeans(Rmatris) # radmedel
rowSums(Rmatris) # radsummor
var(Rmatris) # variansmatris
cor(Rmatris) # korrelationsmatris


# N�gra grundl�ggande plottar av RCOMP OCH RMARK. Obs, resultatet �r inte alltid
# samma som att plotta Rmatris. Detta pga att (plot-)funktionerna �r generiska.

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
plot(RCOMP,type="l",col=1); lines(RMARK,col=2) # H�r l�gger vi ocks� till f�rg
ts.plot(Rmatris,col=1:2) # H�r l�gger vi ocks� till f�rg



################################################################################
# 1.2 MARKNADSMODELLEN #
################################################################################
# Skatta en linj�r regressionsmodellen genom funktionen "lm", d�r y (f�retag) 
# och x (marknad) �r r�nteintensiteter. Vi skattar denna f�r de f�rsta 60 
# avkastningarna, (dvs baserat p� 61 av de 72 dagarna).

# ange antal avkastningar
60 -> N

# Spara ned skattningen av markandsmodellen i objektet "model".
model <- lm(RCOMP[1:N] ~ RMARK[1:N])

# Se p� objektet, en kort sammanfattning med skattade koefficienter ges
model 

# L�ngre sammanfattning, d�ribland skattade koefficienter + p-v�rden
summary(model) 

# Anova tabl�n
anova(model) 

# �r man os�ker vad objektet "model" �r kan man kolla dess klass
class(model)

# Vi kan ocks� ta fram enskilda delar m.h.a. [vald del] (totalt 12 stycken)
model[1] # visade sig vara parameterskattningarna
model[2] # visade sig vara residualerna
model[5] # visade sig vara skattade v�rden

# Vet man vad delen heter g�r det ocks� bra att skriva "$vald_del"
modelres <- model$residuals # spara residualerna fr�n regressionsmodellen
modelfit <- model$fitted.values # spara skattade v�rden fr�n regressionsmodellen
ahat <- model$coefficients[1] # spara ned alfaskattning fr�n regressionen
bhat <- model$coefficients[2] # spara ned betaskattning fr�n regressionen

# Vi kan t�nka oss en portf�lj best�ende endast av Rcomp och sedan ber�kna uppskattad risk
tot <- var(RCOMP[1:N]) # Ber�kna och spara "total risk"
sys <- bhat^2*var(RMARK[1:N]) # Ber�kna och spara "systematisk risk"
spe <- var(modelres) # Ber�kna och spara "specifik risk"
  
  

# Nedanst�ende kod plottar stegvis 2x3-plottar f�r residualerna fr�n marknadsmodellen
dev.off() # St�ng ned tidigare f�nster om s�dant finns, annars ges ett felmeddelande
par(mfcol=c(2,3),cex=1.2,mar=c(5,4,4,2)) # �ppna ett f�nster med 2x3 plottar
# F�rdelningsplott
modelhist <- hist(modelres,plot=F) # Spara ett histogram �ver residualerna i "modelhist"
hist(modelres,prob=T,col="gray",xlim=quantile(modelhist$mids)[c(1,5)]*1.2,ylim=c(0,max(modelhist$density))*1.2,
  main="F�rdelning utan ordning",xlab="Residual",ylab="Andel") # Histogram
lines(density(modelres),col=4,lwd=2) # L�gg till t�thetsskattningen (som ett utj�mnat histogram) med bl� f�rg. Bilden borde d� bli tydligare.
x <- seq(min(modelres)*1.5,max(modelres)*1.5,length=1000) # Ber�kna x-koordinater till en normalf�rdelningskurva
y <- dnorm(x,mean=mean(modelres),sd=sd(modelres)) # Ber�kna y-koordinater till en normalf�rdelningskurva
lines(x,y,col=2,lwd=2) # L�gg till normalf�rdelningskurvan med r�d f�rg
legend("topright",c("'Histogram'","T�thet","Normal"),col=c("Gray","Blue","Red"),pch=15,cex=1.2,bty="n") # L�gg till f�rklaring
# QQ-plot
qqnorm(modelres,main="QQ-plot normalf�rdelning",xlab="Teoretiska kvantiler",ylab="Kvantiler enligt data"); qqline(modelres) # Normal probability
# Residualer mot skattade v�rden
plot(modelres,modelfit,main="Skattade v�rden mot residualer",xlab="Skattade v�rden",ylab="Residualer")
# Ordnad plot
plot(modelres,type="b",main="Ordnade residualer",xlab="Ordning av residualer",ylab="Residual");abline(0,0) 
# Lag plot
plot(modelres[2:N],modelres[1:(N-1)],main="Lag plot med regressionslinje",xlab="Residual tidpunkt t",ylab="Residual tidpunkt t-1")
abline(lm(modelres[1:(N-1)]~modelres[2:N]),col=2);
legend("topleft",legend=paste("R2=",format(round(cor(modelres[1:(N-1)],modelres[2:N])^2,3),nsmall=3),sep=""),bty="n")
# Korrelogram
acf(modelres,main="Korrelogram f�r residualer",xlab="Antal laggar",ylab="Korrelation",ci=.95)


# Om vi vill kunna anv�nda n�gra av ovanst�ende plottar enkelt vid senare 
# tillf�lle s� kan man definiera en ny funktion med ett modelobjekt med
# m�jlighet att v�lja ordning, antal rader, samt kolumner. Kalla funktionen f�r
# resplot(modellobjekt,plottar i ordning,antal rader,antal kolumner) 
resplot <- function (modelobjekt,plottval,antalrader,antalkolumner) { # b�rjan av funktionen
  a1 <- as.numeric(residuals(modelobjekt)); a2 <- as.numeric(fitted.values(modelobjekt)); a3 <- length(a1)
  par(mfcol=c(antalrader,antalkolumner),cex=1.2,mar=c(5,4,4,2)) # G�r 2x2 plottar
  for (a4 in 1:length(plottval)) {
    if (plottval[a4]==1) { # F�rdelningsplott
    a5 <- hist(a1,plot=F) # Spara ett histogram �ver residualerna i "a5"
    hist(a1,prob=T,col="gray",xlim=quantile(a5$mids)[c(1,5)]*1.2,ylim=c(0,max(a5$density))*1.2,
      main="F�rdelning utan ordning",xlab="Residual",ylab="Andel") # Histogram
    lines(density(a1),col=4,lwd=2) # L�gg till t�thetsskattningen (som ett utj�mnat histogram) med bl� f�rg. Bilden borde d� bli tydligare.
    x <- seq(min(a1)*1.5,max(a1)*1.5,length=1000) # Ber�kna x-koordinater till en normalf�rdelningskurva
    y <- dnorm(x,mean=mean(a1),sd=sd(a1)) # Ber�kna y-koordinater till en normalf�rdelningskurva
    lines(x,y,col=2,lwd=2) # L�gg till normalf�rdelningskurvan med r�d f�rg
    legend("top",c("'Histogram'","T�thet","Normal"),col=c("Gray","Blue","Red"),pch=15,cex=1.2,bty="n") # L�gg till f�rklaring
    }; if (plottval[a4]==2) { # QQ-plot
    qqnorm(a1,main="QQ-plot normalf�rdelning",xlab="Teoretiska kvantiler",ylab="Kvantiler enligt data"); qqline(a1) # Normal probability
    }; if (plottval[a4]==3) { # Residualer mot skattade v�rden
    plot(a1,a2,main="Skattade v�rden mot residualer",xlab="Skattade v�rden",ylab="Residualer")
    }; if (plottval[a4]==4) { # Ordnad plot
    plot(a1,type="b",main="Ordnade residualer",xlab="Ordning av residualer",ylab="Residual");abline(0,0) 
    }; if (plottval[a4]==5) { # Lag plot
    plot(a1[2:a3],a1[1:(a3-1)],main="Lag plot med regressionslinje",xlab="Residual tidpunkt t",ylab="Residual tidpunkt t-1")
    abline(lm(a1[1:(a3-1)]~a1[2:a3]),col=2);
    legend("top",legend=paste("R2=",format(round(cor(a1[1:(a3-1)],a1[2:a3])^2,3),nsmall=3),sep=""),bty="n")
    }; if (plottval[a4]==6) { # Korrelogram
    acf(a1,main="Korrelogram f�r residualer",xlab="Antal laggar",ylab="Korrelation",ci=.95)
} } }# slut p� funktionen

# I denna kan vi v�lja valfri ordning f�r de 6 plottarna:
#1=F�rdelningsplott; #2=QQ-plot; #3=Residualer mot skattade v�rden 
#4=Ordnad plot; #5=Lag plot; #6=Korrelogram
# Vill vi ha f�rsta och sista plotten p� en rad och tv� kolumner skriver vi; 
resplot(model, c(1,6), 1, 2)


################################################################################
# 1.3 ABNORMAL RETURNS #
################################################################################
# ber�kna abnormal return f�r det i:te f�retaget de 11 sista dagarna
ARi <- RCOMP[(N+1):71] - ( ahat + bhat*RMARK[(N+1):71] ) 

# Ber�kna varians f�r abnormal returns
myM <- mean(RMARK[1:N]) # Genomsnittlig marknadsavkastning f�r estimationsperioden
kvot <- (RMARK[(N+1):71]-myM)^2 / sum((RMARK[1:N]-myM)^2 ) # Kvotuttrycket inom den stora parentesen
varARi <- sum(model$res^2)/(N-2) * (1 + 1/N + kvot) # Skattad varians f�r AR(I)

# Ber�kna prediktionsintervall f�r abnormal returns
piu95 <- qt(.975,N-2)*varARi^.5
pil95 <- qt(.025,N-2)*varARi^.5
piu80 <- qt(.9,N-2)*varARi^.5
pil80 <- qt(.1,N-2)*varARi^.5


# Plot av abnormal returns inklusive prediktionsintervall
dev.off() # St�ng ned tidigare f�nster om s�dant finns, annars ges ett felmeddelande
par(mfrow=c(1,1),cex=1.2,mar=c(5,4,4,2)) # Ange formatet f�r plotten
yl <- quantile(c(ARi,piu95,pil95))[c(1,5)]*1.2 # Best�m y-gr�nserna f�r figuren
plot(ARi,main="Daglig AR samt prediktionsintervall f�r i:te f�retaget", # H�r b�rjar vi plotta men
  axes=F,xlab="Tidpunkt",ylab="Abnormal return",ylim=yl,pch=15,xlim=c(1,13),col=6) # v�ljer f�rst bort skalorna
axis(1,1:11,-5:5,las=2); axis(2); box() # Vi l�gger till egna skalor samt ritar en box
lines(1:11,rep(0,11),lwd=2) # l�gg till f�rv�ntad avvikande avkastning
lines(1:11,piu95,col=2,lty=2,lwd=3,pch=17) # l�gg till �vre gr�ns 95% pred int
lines(1:11,pil95,col=2,lty=2,lwd=3,pch=17) # l�gg till undre gr�ns 95% pred in
lines(1:11,piu80,col=4,lty=2,lwd=3,pch=17) # l�gg till �vre gr�ns 95% pred int
lines(1:11,pil80,col=4,lty=2,lwd=3,pch=17) # l�gg till undre gr�ns 95% pred in
legend("topright",legend=c("Actual return","Model return","80% pred int","95% pred int"),
  bty="o",col=c(6,1,4,2),pch=15,cex=1.3)

# S�tt in ber�knat CAR d�r det saknas, dvs f�r f�retag i
CAR[i] <- sum(ARi) # cumulative abnormal return f�r grupp i sparas i CAR

# Spara medelv�rdet av CAR i objektet CAR_
CAR_ <- mean(CAR) 
CAR_

# S�tt in CARVAR d�r det saknas, dvs f�r f�retag i 
CARVAR[i] <- sum(varARi) # Skattad varians f�r f�retag (och gruppnummer) i:s CAR, sparas i CARVAR[p� position i]
CARVAR

# Spara skattade variansen medelv�rdet av CAR i objektet CAR_var
CAR_var <- 1/length(CAR)^2*sum(CARVAR) 
CAR_var



# Ibland kan man vilja anv�nda sig av n�gon av de k�nda statistiska f�rdelningarna
??Distributions # Kolla paketet Distributions

# Vad �r t-v�rdet som anv�nds vid dubbelsidigt 95% konfidensintervall om vi har t.ex. 30 frihetsgrader?
qt(p=.975, df=30) # �vre t-v�rde
qt(p=.025, df=30) # Undre t-v�rde

# Vad �r z-v�rdet som anv�nds vid dubbelsidigt 95% konfidensintervall?
qnorm(.975) # �vre z-v�rde
qnorm(.025) # Nedre z-v�rde

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  