%Measures market variance, std dev, expected returns
%and sharpe ratio for the given assets, weights and risk aversion
function [metrics] = fBL_market(W,cov,A)
    var = (W.')*(cov*W);
    std = sqrt(var);
    ER = A*var;
    sharpe = ER/std;
    metrics = [ER;var;std;sharpe];
end

