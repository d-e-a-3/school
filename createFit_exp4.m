function [fitresult, gof] = createFit_exp4(xMean, meanPulse)
%CREATEFIT(XMEAN,MEANPULSE)
%  Create a fit.
%  Data for 'exp4' fit:
%      X Input : xMean
%      Y Output: meanPulse
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%  See also FIT, CFIT, SFIT.
%% Fit: 'exp4'.
[xData, yData] = prepareCurveData( xMean, meanPulse );

% Set up fittype and options.
ft = fittype( 'a*exp(-b*x)+c*exp(-d*x)+e*exp(-f*x)+g*exp(-b*x)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.182752474600794 0.0987786408514166 0.100757623169576 0.644318130193692 0.811580458282477 0.532825588799455 0.350727103576883];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'exp4' );
h = plot( fitresult, xData, yData );
legend( h, 'meanPulse vs. xMean', 'exp4', 'Location', 'NorthEast' );
% Label axes
xlabel xMean
ylabel meanPulse
grid on


