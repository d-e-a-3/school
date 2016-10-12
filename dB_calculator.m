% Measurements in dB can be converted to % using 10 log (P2/P1) [dB]
attenFactor = linspace(0,2,10); % [dB/m]
fiberLength = [0.1 0.25 0.5 1]; % [m]
length1Length = numel(fiberLength);
for i=1:length1Length
attenPercent = 100+100*(1-10.^(attenFactor*fiberLength(i)/10));
plot(attenFactor,attenPercent)
hold on
end
xlabel('dB/m');
ylabel('%T');
% next line is klunky
l=legend(num2str(fiberLength(1)),num2str(fiberLength(2)),num2str(fiberLength(3)),num2str(fiberLength(4)),'location','southwest'); 
title(l,'Fiber Length [m]');
