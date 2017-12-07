%Austin Griffith
%Black Litterman code for matlab
%MATLAB R2015b
%return data excel file should be within the same folder as this code
%runs 3 different scenarios of black litterman and outputs to excel

clear;

%-----------------------------excel--------------------------%
%get US, Foriegn and Emerging equity from excel files
%initializes names and ranges of data
file_read = '2017-BL+-returndata.xlsx';
sheet_read = 'data';
xlrange_data1 = 'C2:E325'; %3 assets
xlrange_data2 = 'C2:G325'; %5 assets
xlrange_rf = 'B2:B325';

%covariance matrix
[cov_returns1] = fBL_read(file_read,sheet_read,xlrange_data1,xlrange_rf);
[cov_returns2] = fBL_read(file_read,sheet_read,xlrange_data2,xlrange_rf);

%-----------------------------BL variables--------------------------%
%estimated optimal weights for each asset classes and risk aversion
%for this code, the weights and risk aversion
%remain the same for each of the 3 scenarios
wUS = 0.5;
wF = 0.4;
wEM = 0.1;
W1 = [wUS;wF;wEM];
wUS = 0.45;
wF = 0.35;
wEM = 0.1;
wUSB = 0.05;
wFB = 0.05;
W2 = [wUS;wF;wEM;wUSB;wFB];
aversion = 3;

%market values
[met_market1] = fBL_market(W1,cov_returns1,aversion);
[met_market2] = fBL_market(W2,cov_returns2,aversion);

%-----------------------------calculations--------------------------%
%confidence parameters
%T is in equilibrium values
%Tv is in manager's views
T1 = 0.1;
Tv1 = 0.1;
T2 = 0.1;
Tv2 = 0.01;
T3 = 0.1;
Tv3 = 0.01;

%managers view
%US excess of 1.5
%Foreign outperforms EM by 3
%EM underperforms by 1
P1 = [1,0,0; 0,1,-1;0,0,-1];
Q1 = [0.015; 0.03; 0.01];
%US excess of 1.5
%Foreign outperforms EM by 3
P2 = [1,0,0; 0,1,-1];
Q2 = [0.015; 0.03];
%Emerging excess of 1
%US outperforms Foreign by 2
%US bond excess of .5
P3 = [0,0,1,0,0; 1,-1,0,0,0; 0,0,0,1,0];
Q3 = [0.01; 0.02; 0.005];

%run black litterman optmization
[p_ret1,p_dist1,const1,met1] = fBL_calc(T1,Tv1,P1,Q1,cov_returns1,W1,aversion);
[p_ret2,p_dist2,const2,met2] = fBL_calc(T2,Tv2,P2,Q2,cov_returns1,W1,aversion);
[p_ret3,p_dist3,const3,met3] = fBL_calc(T3,Tv3,P3,Q3,cov_returns2,W2,aversion);

%-----------------------------excel output--------------------------%
%excel initialization values
assets1 = {'US Equity','Foreign Equity','Emerging Equity'};
assets2 = {'US Equity','Foreign Equity','Emerging Equity','US Bonds','Foreign Bonds'};
file1 = 'BL_output1.xlsx';
file2 = 'BL_output2.xlsx';
file3 = 'BL_output3.xlsx';

%write spreadsheets
fBL_excel(file1,assets1,W1,p_ret1,const1,aversion,T1,Tv1,P1,Q1,p_dist1,met_market1,met1);
fBL_excel(file2,assets1,W1,p_ret2,const2,aversion,T2,Tv2,P2,Q2,p_dist2,met_market1,met2);
fBL_excel(file3,assets2,W2,p_ret3,const3,aversion,T3,Tv3,P3,Q3,p_dist3,met_market2,met3);
