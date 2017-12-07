%Austin Griffith
%Black Litterman code for matlab
%MATLAB R2015b
%return data excel file should be within the same folder as this code
%single scenario of black litterman and outputs to excel

clear;

%-----------------------------read excel--------------------------%
%get US, Foriegn and Emerging equity from excel files
%initializes names and ranges of data
file_read = '2017-BL+-returndata.xlsx';
sheet_read = 'data';
xlrange_data = 'C2:E325';
xlrange_rf = 'B2:B325';

%covariance matrix
[cov_returns] = fBL_read(file_read,sheet_read,xlrange_data,xlrange_rf);

%-----------------------------BL variables--------------------------%
%estimated optimal weights for each asset classes and risk aversion
wUS = 0.5;
wF = 0.4;
wEM = 0.1;
W = [wUS;wF;wEM];
aversion = 3;

%market values
[met_market] = fBL_market(W,cov_returns,aversion);

%-----------------------------calculations--------------------------%
%confidence parameters
%T is in equilibrium values
%Tv is in manager's views
T = 0.1;
Tv = 0.01;

%managers view
%US excess of 1.5
%Foreign outperforms EM by 3
%EM underperforms by 1
P = [1,0,0; 0,1,-1;0,0,-1];
Q = [0.015; 0.03; 0.01];

%run black litterman optmization
[p_ret,p_dist,const,met] = fBL_calc(T,Tv,P,Q,cov_returns,W,aversion);

%-----------------------------excel output--------------------------%
%excel initialization values
assets = {'US Equity','Foreign Equity','Emerging Equity'};
file = 'BL_simple.xlsx';

%write spreadsheets
fBL_excel(file,assets,W,p_ret,const,aversion,T,Tv,P,Q,p_dist,met_market,met);

