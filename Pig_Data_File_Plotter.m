clearvars, clf
FILE_PROPERTIES;
dirname = uigetdir('/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements');
subdirstr = strcat(dirname,'/', datafiletype);
filelist = dir(subdirstr);
[pathstr, name, ext] = fileparts(subdirstr);
numfiles = length(filelist);
for i = 1:numfiles
filename = strcat(pathstr,'/', filelist(i).name);
fid = fopen(filename, 'rt');
T = readtable(filename,'Delimiter',',','ReadVariableNames',false);
SCAN_HEADER_DATA;
PROBE_ID;
M = str2double(T{20:end,:});
x = M(:,1);
y = (M(:,2)-M(20,2));
plot(x,y,datacolor)
    legend off
    hold on
    drawnow update 
fclose(fid);
end
xlabel('Time (s)')
ylabel('°C')
grid on