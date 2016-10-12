clearvars, clf
FILE_PROPERTIES;
basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements';
dirname = uigetdir(basedir);
subdirstr = strcat(dirname,'/', datafiletype);
filelist = dir(subdirstr);
[pathstr, name, ext] = fileparts(subdirstr);
numfiles = length(filelist);
dataLength = 1800; % Defines length of pulses considered for fitting of rising edge, etc.  Sampled at ~14Hz.
thresholdTempRise = 0.03; % Used to define pre-pulse noise threshold in SEPARATE_and_ADJUST_PULSES. tweaky. no likey.
D = zeros(dataLength,1+numfiles*2); % Preallocated array to reduce processing time.
Fit_Coefficients_Self_Heating  % Load power-normalized self-heating fit coefficients
for i = 1:numfiles
filename = strcat(pathstr,'/', filelist(i).name);
fid = fopen(filename, 'rt');
T = readtable(filename,'Delimiter',',','ReadVariableNames',false);
    numRows = size(T,1);
fileDisp = [filelist(i).name,' i= ', num2str(i)];
    disp(fileDisp);
SCAN_HEADER_DATA;
PROBE_ID;
SEPARATE_and_ADJUST_PULSES_NEW;
vectorDisp = ['Y1 = ',num2str(length(yScraped1)),', Y2= ',num2str(length(yScraped2)),', T1_max =',num2str(max(yScraped1(1:dataLength))/pulsePower),', T2_max =',num2str(max(yScraped2(1:dataLength))/pulsePower)];
    disp(vectorDisp);
% Build array of the separated power-normalized pulses for analysis later
C = [D(:,1:2*i-1) yScraped1(1:dataLength)/pulsePower]; % Neglect the first column.  It's all zeros.
D = [C yScraped2(1:dataLength)/pulsePower];
fclose(fid);
end %i
meanRx = mean(D(:,2:end),2); % Find mean of values per row to create average pulse.  Neglect the first column it's all zeros.
timeMean = xScraped1(1:dataLength); % time series for MEAN Rx
plot(timeMean,D(:,2:end),':k');
    grid off
    xlim([0,30]);
    ylim([0,0.35]);
    legend off
    hold on
% Define transport time between probe and heated tissue (hotspot)
alpha = 0.136; % Thermal difffusivity of brain tissue [mm2/s]
l = 0.5; % Distance from hotspot to sensor [mm]
timeLag = l*sqrt(1/(2*alpha)); % Thermal transport time [s]
a = fitCoeff_Therm_635(1);
b = fitCoeff_Therm_635(2);
c = fitCoeff_Therm_635(3);
d = fitCoeff_Therm_635(4);
selfHeating = a*erfc(b./sqrt(c*timeMean))+d;
% lagAdjust = timeMean(timeMean>=timeLag);
% lagLength = length(lagAdjust);
% lagOffset = dataLength - lagLength;
% adjustedMeanRx = meanRx(1:lagLength) - meanRx(lagOffset);
% adjusted_MeanRx = adjustedMeanRx - selfHeating(1:lagLength);
correctedRx = meanRx - selfHeating;
% Remove (-) values from adjusted fit
correctedRx(correctedRx<0)=0;
% plot(timeMean,correctedRx,'--k');
plot(timeMean,meanRx,'--r', timeMean,selfHeating,'--b');
%     grid off
%     xlim([0,30]);
%     ylim([0,0.35]);
%     legend off
%     hold on
% Curve Fitting of ADJUSTED MEAN Waveform
[xData, yData] = prepareCurveData(timeMean,correctedRx);
% % Fit options for tissue rx
% ft = fittype('a*erfc(b/sqrt(c*x))+d','independent','x','dependent','y');
% opts.Display ='Off';
% opts.StartPoint = [0.94673255346855 0.191908364958941 0.608192833325577 0.278498218867048];
% Fit options for corrected rx
ft = fittype( 'a*erfc(b/sqrt(c*x))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 0];
opts.StartPoint = [0.00115251106722081 0.779103974566464 0.718306235347856];
opts.Upper = [10 10 10];
% %  Fit options for thermistor self-heating
% ft = fittype('a*erfc(b/sqrt(c*x))+d','independent','x','dependent','y');
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.DiffMaxChange = 0.02;
% opts.DiffMinChange = 0.0001;
% opts.Display = 'Off';
% opts.Lower = [0.05 0.5 9 0];
% opts.MaxFunEvals = 1000;
% opts.MaxIter = 1000;
% opts.StartPoint = [0.128958419722952 0.884906694951731 0.947793483776331 0.849129305868777];
% opts.TolX = 0.001;
% opts.Upper = [0.3 1 11 0.01];
[fitresult,gof] = fit(xData,yData,ft,opts);
fitCoeff = [fitresult.a,fitresult.b,fitresult.c];
% fitCoeff = [fitresult.a,fitresult.b,fitresult.c,fitresult.d];
% uisave('fitCoeff','Mean_Fit.mat');
plot(fitresult,'r',xData,yData,'-k');
    xlabel('Time (s)','INTERPRETER','none')
    ylabel('Temperature Rise / Power (°C/mW)','INTERPRETER','none')
%     legend(sprintf('%f erfc(%f/sqrt(%f t)) + %f',fitresult.a,fitresult.b,fitresult.c,fitresult.d));
    legend(sprintf('%f erfc(%f/sqrt(%f t))',fitresult.a,fitresult.b,fitresult.c));