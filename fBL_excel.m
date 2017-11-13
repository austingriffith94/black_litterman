%Writes BL values into an organized pdf
%can work with any number of asset classes and manager views
function fBL_excel(file,classes,W,p_ret,const,A,T,Tv,P,Q,p_dist,met_m,met)
%sheet 1 header
xlswrite(file,{'Black Litterman Optimization'},'Sheet 1','A1');

%returns and weights
sheet_main = 'Returns and Weights';
header = {'Asset Classes','Prior Market Weights','Posterior Returns','Optimal Weights'};
xlswrite(file,{sheet_main},sheet_main);
xlswrite(file,header,sheet_main,'A2');
xlswrite(file,classes.',sheet_main,'A3');
xlswrite(file,W,sheet_main,'B3');
xlswrite(file,p_ret,sheet_main,'C3');
xlswrite(file,const.',sheet_main,'D3');

%confidence and manager's views
sheet_man = 'Manager Views';
man_header = {'Manager Views';'Q'};
scalars = {'Risk Aversion';'Uncert. in Prior';'Uncert. in Manager'};
xlswrite(file,scalars,sheet_man,'A1');
xlswrite(file,[A;T;Tv],sheet_man,'B1');
xlswrite(file,man_header,sheet_man,'A5');
xlswrite(file,{'P'},sheet_man,'B6');
xlswrite(file,classes,sheet_man,'B7');
xlswrite(file,P,sheet_man,'B8');
xlswrite(file,Q,sheet_man,'A8');

%posterior returns covariance matrix
sheet_cov = 'Posterior Returns Covariance';
xlswrite(file,{sheet_cov},sheet_cov,'A1');
xlswrite(file,p_dist,sheet_cov,'A2');

%variance, std dev, expected returns, and sharpe
sheet_met = 'Metrics';
portfolio = {'Expected Returns';'Variance';'Std. Deviation';'Sharpe Ratio'};
port_header = {'Market','Optimal Portfolio'};
xlswrite(file,portfolio,sheet_met,'A2');
xlswrite(file,port_header,sheet_met,'B1');
xlswrite(file,met_m,sheet_met,'B2');
xlswrite(file,met,sheet_met,'C2');
end