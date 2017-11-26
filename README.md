# black_litterman
## Black_Litterman_main
This is the main file for the code. Within is the initialization of 3 different scenario's values.

Each scenario varies the following values:
- Weights
- Classes
- Confidence
- Manager Projections

The risk aversion remains constant at 3. There are 3 output files, each with the optimized values calculated in the Black-Litterman (BL) model.

## Black_Litterman_simple
This is another main file, only with one scenario. All the outputs and functions are the same. Created to allow ease of use and simpler exchange of variables in solving for a single optimal portfolio.

## Functions
### fBL_read
This is the function that reads the return data excel file. Raw returns and T-bill returns (for the risk free rate) are taken as vectors. It then calculates the excess returns, and the covariance of the excess returns. The latter is output since it is necessary for many of the BL calculations.

### fBL_market
This is a simple function that calculates the variance, std. dev., expected returns and Sharpe ratio of the excess returns using the market asset weights prior to the BL optimization.

The inputs are:
- Initial weights
- Covariance of the assets returns
- Risk aversion

The outputs are vectors of:
- Variance
- Std. Dev.
- Expected Returns
- Sharpe Ratio

### fBL_calc
This is the function for calculating the Black-Litterman values.

The inputs required are:
- Confidence in initial weights
- Confidence in manager's assumptions
- P matrix
- Q vector
- Covariance of the assets returns
- Initial weights
- Risk aversion

The outputs of the function are:
- Posterior returns
- Posterior covariance matrix
- Optimal constrained portfolio weights
- Vectors of Variance, Std. Dev., Expected Returns and Sharpe Ratio

### fBL_excel
This function automates the writing of the output excel file. The values are output into a series of sheets in an order so that any number of assets and manager's views can be taken and still be formatted correctly.

The output file has the following sheets:
- Sheet 1 - header of file
- Returns and Weights
- Manager Views
- Posterior Returns Covariance
- Metrics - Variance, Std. Dev. Expected Returns and Sharpe Ratio
