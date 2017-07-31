#install.packages("tseries")
library(zoo)
library(tseries)

SNPdata <- get.hist.quote('^gspc',quote="Close")

SNPret <- log(lag(SNPdata)) - log(SNPdata)

SNPvol <- sd(SNPret) * sqrt(250) * 100



## volatility
get
Vol <- function(d, logrets)
{

	var = 0

	lam = 0

	varlist <- c()

	for (r in logrets) {

		lam = lam*(1 - 1/d) + 1
	
	var = (1 - 1/lam)*var + (1/lam)*r^2

		varlist <- c(varlist, var)

	}

	sqrt(varlist)
}


# Recreate Figure 6.12 in the text on page 155

volest <- Vol(10,SNPret)

volest2 <- Vol(30,SNPret)

volest3 <- Vol(100,SNPret)


volest.ts <- zoo(volest, time(SNPdata))
volest2.ts <- zoo(volest2, time(SNPdata))
volest3.ts <- zoo(volest3, time(SNPdata))

#plot(volest,type="l")
	
plot(volest, type = "l", main = "S&P 500(^gspc) Volatility (S&P 500 vs Index)", xlab = "Index", ylab = "S&P 500")
lines(volest2,type="l",col="red")
lines(volest3, type = "l", col="blue")

legend("topleft", inset=.05, title="Decay Factors",
			 c("10","30","100"), fill = c("black", "red", "blue"), horiz=TRUE)


plot(volest.ts, type = "l", main = "S&P 500(^gspc) Volatility (S&P 500 vs Time)", xlab = "Time", ylab = "S&P 500")
lines(volest2.ts,type="l",col="red")
lines(volest3.ts, type = "l", col="blue")

legend("topleft", inset=.05, title="Decay Factors",
			 c("10","30","100"), fill = c("black", "red", "blue"), horiz=TRUE)
