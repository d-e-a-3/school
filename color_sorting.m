clearvars, clf
FILE_PROPERTIES;

basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements/Apparatus';
datadir = '/ThermBehind/'; % All data in separate folders within basedir.
specificdir = strcat(basedir, datadir);
subdirstr = strcat(specificdir, datafiletype);
filelist = dir(subdirstr);
[pathstr, name, ext] = fileparts(subdirstr);
numfiles = length(filelist);
for i = 4:9  % numfiles-3 % Ignore 10% D/C data
filename = strcat(pathstr,'/', filelist(i).name);
    fid = fopen(filename, 'rt');
    T = readtable(filename,'Delimiter',',','ReadVariableNames',false);
    numRows = size(T,1);
SCAN_HEADER_DATA;
PROBE_ID;
SEPARATE_PULSES;
% PROBE_TEMP_RISE;
% ISOLATE_TEMP_RISE;
%     datacolorArray{i} = datacolor;
    legendArray{i} = filelist(i).name;
% figure
plot(x1,y1,datacolor) %/pulsePower
    xlim([0,20]) 
%     ylim([0,0.6]) 
    hold on
plot(x2,y2,datacolor)
    drawnow update 
fclose(fid);
end
[token, remain] = strtok(legendArray,'(');
legendDupes = repelem(remain,2);
legend(legendDupes)
title(strcat(num2str(pulsePower),'mW,', probeID, ',', animalID))
xlabel('Time (min.)')
ylabel('Temperature Rise (°C)')
