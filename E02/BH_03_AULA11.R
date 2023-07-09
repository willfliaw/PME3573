# PME 3573 - Aula 11
# Prof. Dr. Renato Maia Matarazzo Orsino
# Sao Paulo, 07 de Junho de 2023
#   - Regressao por Componentes Principais (PCR)
#   - Regressao Parcial de Minimos Quadrados (PLSR)

# load ggplot2 and pls libraries
library(ggplot2)
library(pls, warn.conflicts = FALSE)

# read data from the CSV file
data <- read.table("./data/BH_03_AIR_1.csv", header = TRUE, sep = "\t")

# a very first look at the imported data file
ggplot(data) +
  geom_line(aes(x = Time, y = L03.Y, color = "L03"), linewidth = 0.10) +
  geom_line(aes(x = Time, y = M28.Y, color = "M28"), linewidth = 0.15) +
  geom_line(aes(x = Time, y = A01.Y, color = "A01"), linewidth = 0.20) +
  labs(x = "t (s)", y = "y (mm)",
       title = "Time series of y coordinates for targets A01, M28 and L03")

# normalization of data
ColRange <- grep("X|Y|Z", names(data))
A. <- max(abs(data$L03.Y - mean(data$L03.Y)))
mean_vec <- c()

for (col in ColRange){
  m. <- mean(data[, col])
  data[,col] <- ((data[, col] - m.)/A.)
  mean_vec <- c(mean_vec, m.)
}

# selection of training set
TrSet.start = 90500
TrSet.end = 118000
TrSet = TrSet.start:TrSet.end

# selection of test set
TsSet.start = 152000
TsSet.end = 180000
TsSet = TsSet.start:TsSet.end

ggplot() +
  geom_line(aes(x = data$Time, y = data$L03.Y, color = "data"), linewidth = 0.05) +
  geom_line(aes(x = data$Time[TrSet], y = data$L03.Y[TrSet], color = "training set"), linewidth = 0.08) +
  geom_line(aes(x = data$Time[TsSet], y = data$L03.Y[TsSet], color = "test set"), linewidth = 0.08) +
  labs(x = "t (s)", y = "y",
       title = "Time series of nondimensional y coordinate of target L03")

# clamped-free Euler-Bernoulli beam modes (for comparison)
l.eb <- c(1.8751, 4.69409, 7.85476, 10.9955, 14.1372)
EulerBernoulli <- function(i, s){
  cosh(s*l.eb[i]) - cos(s*l.eb[i]) - (sinh(l.eb[i]) - sin(l.eb[i])) / (cosh(l.eb[i]) + cos(l.eb[i])) * (sinh(s*l.eb[i]) - sin(s*l.eb[i]))
}

ggplot() +
  geom_line(aes(x = seq(0, 1, by=0.01), y = EulerBernoulli(1, seq(0, 1, by=0.01)), color = "EB 1")) +
  geom_line(aes(x = seq(0, 1, by=0.01), y = EulerBernoulli(2, seq(0, 1, by=0.01)), color = "EB 2")) +
  geom_line(aes(x = seq(0, 1, by=0.01), y = EulerBernoulli(3, seq(0, 1, by=0.01)), color = "EB 3")) +
  labs(x = "nondimensional arc-length", y = "nondimensional amplitude",
       title = "Clamped-free Euler-Bernoulli beam modes")

### --- PART I: PCR --- ###

# Principal Component Analysys (PCA)
ColRangeY <- grep("Y", names(data))
Ut <- as.matrix(cbind(data[TrSet, ColRangeY], data[TrSet+1, ColRangeY]))
K <- (t(Ut) %*% Ut)/length(TrSet)
rm(Ut)
evp.K <- eigen(K)

plot(evp.K$values, log="y", xlab="# eigenvalue", ylab="eigenvalue")

plot(cumsum(evp.K$values)/sum(evp.K$values), log="y",
     xlab="# eigenvalue", ylab="cumulative sum of eigenvalue")

# Principal component modes BH-3-AIR vs. Euler-Bernoulli beam modes
evp.size <- dim(evp.K$vectors)[1]
TargetRange = (1+evp.size/2):evp.size

modes.data <- data.frame(
  s = seq(0, 1, length.out = evp.size/2),
  PC1 = evp.K$vectors[TargetRange,1]/evp.K$vectors[evp.size,1],
  PC2 = evp.K$vectors[TargetRange,2]/evp.K$vectors[evp.size,2],
  PC3 = evp.K$vectors[TargetRange,3]/evp.K$vectors[evp.size,3],
  PC4 = evp.K$vectors[TargetRange,4]/evp.K$vectors[evp.size,4],
  EB1 = EulerBernoulli(1, seq(0, 1, length.out = evp.size/2))/EulerBernoulli(1,1),
  EB2 = EulerBernoulli(2, seq(0, 1, length.out = evp.size/2))/EulerBernoulli(2,1),
  EB3 = EulerBernoulli(3, seq(0, 1, length.out = evp.size/2))/EulerBernoulli(3,1),
  EB4 = EulerBernoulli(4, seq(0, 1, length.out = evp.size/2))/EulerBernoulli(4,1)
)

ggplot(modes.data) +
  geom_line(aes(x=s, y=EB1, color = "EB 1"), linewidth = 0.4, linetype = 2) +
  geom_line(aes(x=s, y=EB2, color = "EB 2"), linewidth = 0.4, linetype = 2) +
  geom_line(aes(x=s, y=EB3, color = "EB 3"), linewidth = 0.4, linetype = 2) +
  geom_line(aes(x=s, y=PC1, color = "PC 1"), linewidth = 0.8) +
  geom_line(aes(x=s, y=PC2, color = "PC 2"), linewidth = 0.8) +
  geom_line(aes(x=s, y=PC3, color = "PC 3"), linewidth = 0.8) +
  geom_line(aes(x=s, y=PC4, color = "PC 4"), linewidth = 0.8) +
  labs(x = "nondimensional arc-length", y = "nondimensional amplitude",
       title = "Principal component modes BH-3-AIR vs. Euler-Bernoulli beam modes")

# orthogonality test
(evp.K$vectors[,2] %*% evp.K$vectors[,1])

# reduced order model (ROM) for L03.Y some frames forward
frames.forward = 100

# - (a) reduced order model from the PCA performed with data from training set
Ut <- as.matrix(cbind(data[TsSet, ColRangeY], data[TsSet+1, ColRangeY]))
V <- as.matrix(cbind(evp.K$vectors[,1], evp.K$vectors[,2], evp.K$vectors[,3]))
Zt <- Ut %*% V
ROM.PCA.L03.Y <- lm(data[TsSet + frames.forward, "L03.Y"] ~ Zt)

# - (b) built-in pcr function (from pls library) applied direct to the test set
ROM.pcr.L03.Y <- pcr(data[TsSet + frames.forward, "L03.Y"] ~ Ut, ncomp = 3)

rm(Ut, Zt)

ggplot() +
  geom_line(aes(x = data$Time, y = data$L03.Y, color = "data"), linewidth = 0.04) +
  geom_line(aes(x = data$Time[TrSet], y = data$L03.Y[TrSet], color = "training set for PCA"), linewidth = 0.06) +
  geom_line(aes(x = data$Time[TsSet + frames.forward], y = predict(ROM.pcr.L03.Y)[,,3], color = "built-in PCR"), linewidth = 0.1) +
  geom_line(aes(x = data$Time[TsSet + frames.forward], y = predict(ROM.PCA.L03.Y), color = "PCR via PCA"), linewidth = 0.08) +
  labs(x = "t (s)", y = "y",
       title = "Reduced order model for the nondimensional y coordinate of target L03")

# reduced order model (ROM) error
ggplot() +
  geom_line(aes(x = data$Time[TsSet + frames.forward], y = data$L03.Y[TsSet+frames.forward] - predict(ROM.PCA.L03.Y), color = "PCR via PCA"), linewidth = 0.1) +
  geom_line(aes(x = data$Time[TsSet + frames.forward], y = data$L03.Y[TsSet+frames.forward] - predict(ROM.pcr.L03.Y)[,,3], color = "built-in PCR"), linewidth = 0.2) +
  labs(x = "t (s)", y = "e",
       title = "Error in the reduced order model for the nondimensional y coordinate of target L03")

# mean-square error (MSE)
MSE.ROM.PCA.L03.Y <- mean((data$L03.Y[TsSet+frames.forward] - predict(ROM.PCA.L03.Y))^2)
MSE.ROM.pcr.L03.Y <- mean((data$L03.Y[TsSet+frames.forward] - predict(ROM.pcr.L03.Y)[,,3])^2)


### --- PART II: PLSR --- ###

# initializing PLSR algorithm
ColRangeY <- grep("Y", names(data))
frames.forward = 100
Ut <- as.matrix(cbind(data[TrSet, ColRangeY], data[TrSet+1, ColRangeY]))
St <- as.matrix(data[TrSet + frames.forward, ColRangeY])
K <- (t(Ut) %*% Ut)/length(TrSet)
C <- (t(Ut) %*% St)/length(TrSet)
rm(Ut, St)
R_0 <- sum(diag(K))

mu <- 10
m <- dim(C)[1]
l <- dim(C)[2]
P <- matrix(nrow = m, ncol = mu)
Q <- matrix(nrow = l, ncol = mu)
V_1 <- matrix(nrow = m, ncol = mu)
kp <- vector(length = mu)

# PLSR loop
for (k in 1:mu){
  V_1[,k] <- svd(C)$u[,1]
  g <- 1 / (V_1[,k] %*% K %*% V_1[,k])
  P[,k] <- g[1] * K %*% V_1[,k]
  Q[,k] <- g[1] * t(C) %*% V_1[,k]
  K[,] <- K[,] - P[,k] %*% t(V_1[,k]) %*% K[,]
  C[,] <- C[,] - P[,k] %*% t(V_1[,k]) %*% C[,]
  kp[k] <- sum(diag(K))/R_0
}

# PLS vs. PCA vs. Euler-Bernoulli
modes.data <- data.frame(
  s = seq(0, 1, length.out = evp.size/2),
  EB1 = EulerBernoulli(1, seq(0, 1, length.out = evp.size/2))/EulerBernoulli(1,1),
  EB2 = EulerBernoulli(2, seq(0, 1, length.out = evp.size/2))/EulerBernoulli(2,1),
  EB3 = EulerBernoulli(3, seq(0, 1, length.out = evp.size/2))/EulerBernoulli(3,1),
  EB4 = EulerBernoulli(4, seq(0, 1, length.out = evp.size/2))/EulerBernoulli(4,1),
  PC1 = evp.K$vectors[TargetRange,1]/evp.K$vectors[evp.size,1],
  PC2 = evp.K$vectors[TargetRange,2]/evp.K$vectors[evp.size,2],
  PC3 = evp.K$vectors[TargetRange,3]/evp.K$vectors[evp.size,3],
  PC4 = evp.K$vectors[TargetRange,4]/evp.K$vectors[evp.size,4],
  PLS.P1 = P[TargetRange,1]/P[m,1],
  PLS.P2 = P[TargetRange,2]/P[m,2],
  PLS.P3 = P[TargetRange,3]/P[m,3],
  PLS.P4 = P[TargetRange,4]/P[m,4],
  PLS.P5 = P[TargetRange,5]/P[m,5],
  PLS.Q1 = Q[,1]/Q[l,1],
  PLS.Q2 = Q[,2]/Q[l,2],
  PLS.Q3 = Q[,3]/Q[l,3],
  PLS.Q4 = Q[,4]/Q[l,4],
  PLS.Q5 = Q[,5]/Q[l,5]
)

ggplot(modes.data) +
  geom_line(aes(x=s, y=EB1, color = "EB 1"), linewidth = 0.4, linetype = 2) +
  geom_line(aes(x=s, y=PC1, color = "PC 1"), linewidth = 0.7) +
  geom_line(aes(x=s, y=PLS.P1, color = "PLS P1"), linewidth = 1.0) +
  labs(x = "nondimensional arc-length", y = "nondimensional amplitude",
       title = "PLS and PCA modes for BH-3-AIR vs. Euler-Bernoulli beam modes")

ggplot(modes.data) +
  geom_line(aes(x=s, y=EB2, color = "EB 2"), linewidth = 0.4, linetype = 2) +
  geom_line(aes(x=s, y=PC2, color = "PC 2"), linewidth = 0.7) +
  geom_line(aes(x=s, y=PLS.P2, color = "PLS P2"), linewidth = 1.0) +
  labs(x = "nondimensional arc-length", y = "nondimensional amplitude",
       title = "PLS and PCA modes for BH-3-AIR vs. Euler-Bernoulli beam modes")

ggplot(modes.data) +
  geom_line(aes(x=s, y=EB2, color = "EB 2"), linewidth = 0.4, linetype = 2) +
  geom_line(aes(x=s, y=PC3, color = "PC 3"), linewidth = 0.7) +
  geom_line(aes(x=s, y=PLS.P3, color = "PLS P3"), linewidth = 1.0) +
  labs(x = "nondimensional arc-length", y = "nondimensional amplitude",
       title = "PLS and PCA modes for BH-3-AIR vs. Euler-Bernoulli beam modes")

ggplot(modes.data) +
  geom_line(aes(x=s, y=EB3, color = "EB 3"), linewidth = 0.4, linetype = 2) +
  geom_line(aes(x=s, y=PC4, color = "PC 4"), linewidth = 0.7) +
  geom_line(aes(x=s, y=PLS.P4, color = "PLS P4"), linewidth = 1.0) +
  labs(x = "nondimensional arc-length", y = "nondimensional amplitude",
       title = "PLS and PCA modes for BH-3-AIR vs. Euler-Bernoulli beam modes")


# reduced order model (ROM) for L03.Y some frames forward

# - (a) reduced order model from the PLSR performed with data from training set
U <- t(as.matrix(cbind(data[TsSet, ColRangeY], data[TsSet+1, ColRangeY])))
S <- t(as.matrix(data[TsSet+frames.forward, ColRangeY]))
Z <- matrix(nrow = mu, ncol = length(TsSet))
for (k in 1:3){
  Z[k,] <- t(V_1[,k]) %*% U
  U[,] <- U[,] - P[,k] %*% t(Z[k,])
  S[,] <- S[,] - Q[,k] %*% t(Z[k,])
}
ROM.myPLSR.L03.Y <- S[l,]
rm(U, S, Z)

# - (b) built-in plsr function (from pls library) applied direct to the test set
Ut <- as.matrix(cbind(data[TsSet, ColRangeY], data[TsSet+1, ColRangeY]))
St <- as.matrix(data[TsSet+frames.forward, ColRangeY])
ROM.plsr <- plsr(St ~ Ut, ncomp = 3)
rm(Ut, St)

# reduced order model (ROM) error
ggplot() +
  geom_line(aes(x = data$Time[TsSet+frames.forward], y = ROM.myPLSR.L03.Y, color = "my PLRS"), linewidth = 0.1) +
  geom_line(aes(x = data$Time[TsSet+frames.forward], y = data$L03.Y[TsSet+frames.forward] -  predict(ROM.plsr)[,"L03.Y",3], color = "built-in PLSR"), linewidth = 0.2) +
  labs(x = "t (s)", y = "e",
       title = "Error in the reduced order model for the nondimensional y coordinate of target L03")

# mean-square error (MSE)
MSE.ROM.myPLSR.L03.Y <- mean((ROM.myPLSR.L03.Y)^2)
MSE.ROM.plsr.L03.Y <- mean((data$L03.Y[TsSet+frames.forward] -  predict(ROM.plsr)[,"L03.Y",3])^2)

