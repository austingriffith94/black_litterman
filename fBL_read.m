function [covariance] = fBL_read(file,sheet,data,rf)
%values read from data
ereturns = xlsread(file,sheet,data);
risk_free = xlsread(file,sheet,rf);

%number of assets being assessed
n = size(ereturns);
n = n(1,2);

%calculate excess returns
for i = 1:1:n
    ereturns(:,i) = ereturns(:,i) - risk_free;
end;

%covariance matrix
covariance = cov(ereturns);
end

