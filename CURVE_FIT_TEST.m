% Define Threshold Delta T to determine start of detected pulse
thresholdTempRise = 0.05;
tempRiseStart=find(y>thresholdTempRise);
truncateLength = length(y)-length(tempRiseStart);
y = data(truncateLength:end,2);
x = data(truncateLength:end,1);
% NEED TO RESET X1=0, MAKE Y1=0?)
% ALSO NEED TO APPLY FIT ONLY TO HEATING (FIRST HALF OF BIPHASIC) MEASUREMENT
[f,gof] = fit(x,y,'exp2');
plot(f,x,y,'predobs');
    xlim([0 30]);
    xlabel('time(s)');
    ylabel('Temp. (°C)');
    title(datafiletype,'Interpreter','none');
formula(f);
ci = predint(f,x);
    legend({'Data', sprintf('$T = %3.1fe^{(%1.2ex)}+%3.2fe^{(%1.2ex)}$',f.a,f.b,f.c,f.d),'CL95'},'Location','southeast','Interpreter','latex');
        plotFileName = strcat(subdirstr, '_plot.pdf');
            saveas(gcf, fullfile(plotFileName),'pdf');