% RECURSIVE APPLICATION OF CURVE FITTING TO DETERMINE THE DISCONTINUITY DUE TO PROBE SELF-HEATING.
gof.rsquare = 1
i = 10;
while gof.rsquare > 0.9
    i = i+1
    xf = dataPulse1(1:i,1)
    yf = dataPulse1(1:i,2)
[f,gof] = fit(xf,yf,'exp1')
gof.rsquare
end
% formula(f);
% % DEFINE 95% CONFIDENCE INTERVALS FOR CURVE FIT
% ci = predint(f,x,0.95);
% DEFINE RELEVANT METADATA FOR DISPLAY ON PLOTS
%     legend({'Data', sprintf('$T = %3.1fe^{(%1.2ex)}+%3.2fe^{(%1.2ex)}$',f.a,f.b,f.c,f.d),'CL95'},'Location','southeast','Interpreter','latex');   
%         plotFileName = strcat(subdirstr, '_plot.pdf');
%             saveas(gcf, fullfile(plotFileName),'pdf');
% plot(x,y,f);