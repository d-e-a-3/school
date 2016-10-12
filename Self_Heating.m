% meanPulse = mean(D(:,2:end),2); % Find mean of values per row to create average pulse
% xx = linspace(0,30,30)';
% xMean = xScraped1(1:1800);
% a = fitCoeff_Therm_635(1);
% b = fitCoeff_Therm_635(2);
% c = fitCoeff_Therm_635(3);
% d = fitCoeff_Therm_635(4);
% % selfHeating = a*erfc(b/sqrt(c*xx));
% selfHeating = (a)*(erfc((b)/sqrt(c*x)))
% % adjustedMean = meanPulse-selfHeating'
% plot(xx,selfHeating,'*b')
% % xMean, meanPulse, '*r', xMean, adjustedMean,'*k'

% x = 0:1:6;
% t = [0.1 5 100];
% a = 5;
% k = 2;
% b = 1;
% figure(1)
%     u = (a/2)*(erf((x-b)/sqrt(4*k*t(1))));
%     plot(x,u)

x = 0:1:30;
t = [0.1 5 100];
a = 5;
k = 2;
b = 1;
figure(1)
u = a*erf(1./sqrt(4*x'));
    plot(x,u,'*r')