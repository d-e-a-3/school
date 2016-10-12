% APPLY FIT ONLY TO HEATING (FIRST HALF OF BIPHASIC) MEASUREMENT
[f,gof] = fit(x,y,'exp2');
cost_func = 'NRMSE';
fit = goodnessOfFit(y,yref,cost_func);
plot(f,x,y,'predobs');
    xlim([0 30]);
    xlabel('time(s)');
    ylabel('Temp. (°C)');
%     title(datafiletype,'Interpreter','none');
% formula(f);
% ci = predint(f,x);
%     legend({'Data', sprintf('$T = %3.1fe^{(%1.2ex)}+%3.2fe^{(%1.2ex)}$',f.a,f.b,f.c,f.d),'CL95'},'Location','southeast','Interpreter','latex');
%         plotFileName = strcat(subdirstr, '_plot.pdf');
%             saveas(gcf, fullfile(plotFileName),'pdf');