# load ggplot2 libraries
options(tidyverse.quiet = TRUE)
library(ggplot2)

# read dataBH3 from the CSV file
dataBH3 <- read.table("./data/BH_03_AIR_1.csv", header = TRUE, sep = "\t")

# a very first look at the imported dataBH3 file
head(dataBH3)
class(dataBH3)
str(dataBH3)
names(dataBH3)

ggplot(dataBH3) +
  geom_line(aes(x = Time, y = L03.X, color = "L03"), linewidth = 0.10) +
  geom_line(aes(x = Time, y = M28.X, color = "M28"), linewidth = 0.15) +
  geom_line(aes(x = Time, y = A01.X, color = "A01"), linewidth = 0.20) +
  labs(x = "t (s)", y = "x (mm)",
       title = "Time series of x coordinates for targets A01, M28 and L03")

ggplot(dataBH3) +
  geom_line(aes(x = Time, y = L03.Y, color = "L03"), linewidth = 0.10) +
  geom_line(aes(x = Time, y = M28.Y, color = "M28"), linewidth = 0.15) +
  geom_line(aes(x = Time, y = A01.Y, color = "A01"), linewidth = 0.20) +
  labs(x = "t (s)", y = "y (mm)",
       title = "Time series of y coordinates for targets A01, M28 and L03")

ggplot(dataBH3) +
  geom_line(aes(x = Time, y = L03.Z, color = "L03"), linewidth = 0.10) +
  geom_line(aes(x = Time, y = M28.Z, color = "M28"), linewidth = 0.15) +
  geom_line(aes(x = Time, y = A01.Z, color = "A01"), linewidth = 0.20) +
  labs(x = "t (s)", y = "z (mm)",
       title = "Time series of z coordinates for targets A01, M28 and L03")


# multivariate linear regression via lm function
L03.Y.r0 <- lm(dataBH3[, "L03.Y"] ~ as.matrix(dataBH3[, c("L01.Y","L02.Y")]))

L03.Y.p0 <- predict(L03.Y.r0, newdata = dataBH3[, c("L01.Y","L02.Y")])
L03.Y.e0 <- (dataBH3[,"L03.Y"] - L03.Y.p0)

ggplot() +
  geom_line(aes(x = dataBH3$Time, y = dataBH3[,"L03.Y"], color = "Data"), linewidth = 0.15) +
  geom_line(aes(x = dataBH3$Time, y = L03.Y.p0, color = "Model"), linewidth = 0.10) +
  labs(x = "t (s)", y = "y (mm)",
       title = "Time series of actual vs. predicted y coordinate of target L03")

ggplot() +
  geom_line(aes(x = dataBH3$Time, y = L03.Y.e0, color = "error"), linewidth = 0.10) +
  labs(x = "t (s)", y = "e (mm)",
       title = "Time series of the prediction error of the y coordinate of target L03")


# training and test sets
n.t = 50000
TrainingSet = 1:n.t
TestSet = (n.t + 1):nrow(dataBH3)

L03.Y.r <- lm(dataBH3[TrainingSet, "L03.Y"] ~ as.matrix(dataBH3[TrainingSet, c("L01.Y","L02.Y")]))

coef <- summary(L03.Y.r)$coefficients[1:3,"Estimate"]

L03.Y.p <-  as.matrix(dataBH3[, c("L01.Y","L02.Y")]) %*% coef[-1] + coef[1]
L03.Y.e <- (dataBH3[,"L03.Y"] - L03.Y.p)

ggplot() +
   geom_line(aes(x = dataBH3$Time[TrainingSet], y = dataBH3[TrainingSet,"L03.Y"], color = "Training Data"), linewidth = 0.15) +
   geom_line(aes(x = dataBH3$Time[TestSet], y = dataBH3[TestSet,"L03.Y"], color = "Test Data"), linewidth = 0.12) +
   geom_line(aes(x = dataBH3$Time, y = L03.Y.p, color = "Model"), linewidth = 0.10) +
   labs(x = "t (s)", y = "y (mm)",
       title = "Time series of actual vs. predicted y coordinate of target L03")

ggplot() +
  geom_line(aes(x = dataBH3$Time[TrainingSet], y = L03.Y.e[TrainingSet], color = "Training set"), linewidth = 0.10) +
  geom_line(aes(x = dataBH3$Time[TestSet], y = L03.Y.e[TestSet], color = "Test set"), linewidth = 0.10) +
  labs(x = "t (s)", y = "e (mm)",
       title = "Time series of the prediction error of the y coordinate of target L03")

