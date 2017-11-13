%Black Litterman Calculations
function [p_returns,p_dist,constrained,metrics] = fBL_calc(T,Tv,P,Q,cov_returns,W,A)
%values for future equations
cov_tau = T*cov_returns;
omega = Tv*P*cov_returns*(P.');
prior_returns = A*(cov_returns*W);

%prior precision of views
prior_prec = P*T*cov_returns*(P.');

%posterior values
%posterior returns
val1 = cov_tau*(P.');
val1 = val1*(((P*cov_tau*(P.')) + omega)^-1);
val1 = val1*(Q - P*prior_returns);
p_returns = prior_returns + val1;
%posterior return distribution
val2 = P*cov_tau;
val2 = cov_tau - cov_tau*(P.')*((prior_prec + omega)^-1)*val2;
p_dist = cov_returns + val2;

%optimization
unconstrained = (p_returns.')*((A*p_dist)^-1);
constrained = unconstrained/(sum(unconstrained));

%values
ER = constrained*p_returns;
Variance = constrained*p_dist*constrained.';
Std = sqrt(Variance);
Sharpe = ER/Std;
metrics = [ER;Variance;Std;Sharpe];
end