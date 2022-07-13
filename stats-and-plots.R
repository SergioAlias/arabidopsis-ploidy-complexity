### Script para el análisis estadístico y gráfico - Sergio Alías Segura ###

# Directorio de trabajo
setwd("/home/salias/UGR/TFM/R")

# Carga de paquetes
library(lme4)
library(lmerTest)
library(ggplot2)

# Carga de los datos
datos_arabidopsis <- read.csv(file = "info-arabidopsis-2-4.csv", header = TRUE, sep = ";")

## Análisis ploidía VS número de genes y transcritos ##

# Ajuste de los modelos mixtos
m.genes <- lmer(Tgenes ~ ploidy + (1|sample), data = datos_arabidopsis)

m.transcritos <- lmer(Ttranscripts ~ ploidy + (1|sample), data = datos_arabidopsis)

# Análisis estadístico
summary(m.genes)
anova(m.genes)

summary(m.transcritos)
anova(m.transcritos)

# Representación gráfica
plot_genes <- ggplot(datos_arabidopsis, aes(x = ploidy, y = Tgenes)) + geom_point() + stat_smooth(method = "lm", col = "green4") + scale_x_continuous(breaks=c(2,4))
plot_genes + labs(title="Diagrama de dispersión: genes expresados por nivel de ploidía", x ="Nivel de ploidía, X", y = "Genes expresados") + theme(plot.title = element_text(hjust=0.5))

plot_transcritos <- ggplot(datos_arabidopsis, aes(x = ploidy, y = Ttranscripts)) + geom_point() + stat_smooth(method = "lm", col = "green4") + scale_x_continuous(breaks=c(2,4))
plot_transcritos + labs(title="Diagrama de dispersión: transcritos por nivel de ploid�a", x ="Nivel de ploidía, X", y = "Transcritos") + theme(plot.title = element_text(hjust=0.5))

datos_arabidopsis$ploidy <- as.factor(datos_arabidopsis$ploidy)

box_genes <- ggplot(datos_arabidopsis, aes(x = ploidy, y = Tgenes)) + geom_boxplot(notch=TRUE, fill='#92DAB8', color="black")
box_genes + labs(title="Diagrama de caja: genes expresados por nivel de ploidía", x ="Nivel de ploidía, X", y = "Genes expresados") + theme(plot.title = element_text(hjust=0.5))

box_transcritos <- ggplot(datos_arabidopsis, aes(x = ploidy, y = Ttranscripts)) + geom_boxplot(notch=TRUE, fill='#92DAB8', color="black")
box_transcritos + labs(title="Diagrama de caja: transcritos por nivel de ploidía", x ="Nivel de ploidía, X", y = "Transcritos") + theme(plot.title = element_text(hjust=0.5))