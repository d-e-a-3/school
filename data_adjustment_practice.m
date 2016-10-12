clearvars, clf
t = linspace(0,30,1000);
alpha = 0.136; % [mm2/s]
l = 0.5; % [mm]
timeLag = 2 %sqrt(1/(2*alpha))*l;
v = 0.1796*exp(0.006404*t)-.1418*exp(-.4108*t);
v1 = 0.1796*exp(0.006404*(t-timeLag))-.1418*exp(-.4108*(t-timeLag));
v11 = v1-v1(1);
v2 = 0.1016*exp(-0.0005577*(t))-0.08332*exp(-1.8371*(t));
v22 = v2-v2(1);
vv = v11-v22;
plot(t,v,':r',t,v1,'k',t,v11,'-g',t,v2,':b',t,vv,'-m');
% title(strcat(num2str(pulsePower),'mW,', probeID, ',', animalID))
xlabel('Time (s)','interpreter', 'none')
ylabel('Temperature Rise / Power (°C/mW)')
grid on