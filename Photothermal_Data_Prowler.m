clearvars, clf
FILE_PROPERTIES;
basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements';
dirname = uigetdir(basedir);
subdirstr = strcat(dirname,'/', datafiletype);
filelist = dir(subdirstr);
[pathstr, name, ext] = fileparts(subdirstr);
numfiles = length(filelist);
for i = 1:numfiles % Ignore 10% D/C data
filename = strcat(pathstr,'/', filelist(i).name);
fid = fopen(filename, 'rt');
T = readtable(filename,'Delimiter',',','ReadVariableNames',false);
    numRows = size(T,1);
display(filelist(i).name)
    SCAN_HEADER_DATA;
%     legendArray{i} = filelist(i).name;
PROBE_ID;
    thresholdTempRise = 0.1;
SEPARATE_PULSES;
% PROBE_TEMP_RISE;
   % Used in Isolate_Temp_Rise.  tweaky.  me no likey.
ISOLATE_TEMP_RISE;
% FIT_RISING_EDGE;
plot(x1,y1/pulsePower,datacolor) %/pulsePower
    xlim([0,30]);
    legend off
    hold on
% plot(f1,fitcolor) 
plot(x2,y2/pulsePower,datacolor)
% plot(f2,fitcolor) 
drawnow update 
% cf1 = formula(f1);
% cf2 = formula(f2);
fclose(fid);
end
% [token, remain] = strtok(legendArray,'(');
% legendDupes = repelem(remain,2);
% legend(legendDupes)
title(strcat('Probe= "',probeID, '" , Animal= ', animalID))
xlabel('Time (s)')
ylabel('Temperature Rise / Power (°C/mW)')
grid on
