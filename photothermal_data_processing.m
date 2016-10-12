%
% Read original .csv data file.
% Separate pulses based on timing, where rows:
%       0-18        contain Header and variable data,
%       19-half     contain Pulse 1 data,
%       half-end    contain Pulse 2 data.
% Adjust for Delta t.
% Adjust for Delta T.
% Rename and Save file with _PulseX extension, where X = original pulse #,
% include all original header data.
% Move files to a new unique directory to keep things clean(er).
% 
clearvars
basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements/Test Data';
datadir = '/Intralipid/'; % All data in separate folders within basedir/.
datafiletype = '*.csv'; % *.csv format used for LabVIEW results.
specificdir = strcat(basedir, datadir);
subdirstr = strcat(specificdir, datafiletype);
filelist = dir(subdirstr);
numfiles = length(filelist);
[pathstr, name, ext] = fileparts(subdirstr);
endHeaderRow = 18;
for i = 1 : 1 %numfiles
filename = strcat(pathstr,'/', filelist(i).name);
    fid = fopen(filename, 'rt');
% -- EXTRACT HEADER DATA --
T = readtable(filename,'Delimiter',',','ReadVariableNames',false)
%     headerData = cell2table(T{1:15,:});
        headerData = T{1:15,1:2}
% -- SCAN HEADER DATA --
line1 = fgets(fid); %space
line2 = fgets(fid); %Date
line3 = fgets(fid); %Time
    time = sscanf(line3, ['Time,' '%t'])';
line4 = fgets(fid); %scanner laser 1:blue, 2: green, 0: red
    color = sscanf(line4, ['Laser,' '%d'])';
line5 = fgets(fid); %fiber id
line6 = fgets(fid); %power percentage
    power = sscanf(line6, ['Power (percent),' '%d'])';
line7 = fgets(fid); %On time(ms)
line8 = fgets(fid); %Off time(ms)
line9 = fgets(fid); %# pulses
    pulses = sscanf(line9, ['# Pulses,' '%d'])';
line10 = fgets(fid); %Wait Time(ms)
line11 = fgets(fid); %# bursts
line12 = fgets(fid); %Log time (sec)
    logtime = sscanf(line12, ['Log time (sec),' '%d'])';
line13 = fgets(fid); %Animal ID
line14 = fgets(fid); %Probe ID
line15 = fgets(fid); %Probe X(mm)
line16 = fgets(fid); %Probe Y(mm)
line17 = fgets(fid); %Probe Z(mm)
    posX = sscanf(line15, ['Probe X (mm),' '%d'])';
    posY = sscanf(line16, ['Probe Y (mm),' '%d'])';
    posZ = sscanf(line17, ['Probe Z (mm),' '%d'])';
% -- SEPARATE PULSES --
numRows = size(T,1);
endPulse1Row = round((numRows - endHeaderRow)/2 + endHeaderRow,0);
dataPulse1 = str2double(T{endHeaderRow+1:endPulse1Row,:})
%     dataPulse1 = cell2mat(T{endHeaderRow+1:endPulse1Row,1:2})
% dataPulse1 = csvread(filename, endHeaderRow+1,0,[endHeaderRow+1 0 endPulse1Row 1]);
        x1 = dataPulse1(:,1);
        y1 = dataPulse1(:,2);       
        plot(x1,y1)
%     dataPulse2 = csvread(filename, endPulse1Row,0,[endPulse1Row 0 numRows 1]);
%         x2 = dataPulse2(:,1);
%         y2 = dataPulse2(:,2);
% % -- MAKE TIME RELATIVE, t1=0 --        
% x1TimeShifted = dataPulse1(:, 1) - dataPulse1(1, 1);
%     dataPulse1 = [x1TimeShifted,y1];
%         x1 = dataPulse1(:, 1);
%         y1 = dataPulse1(:, 2);     
% x2TimeShifted = dataPulse2(:, 1) - dataPulse2(1, 1);
%     dataPulse2 = [x2TimeShifted,y2];
%         x2 = dataPulse2(:, 1);
%         y2 = dataPulse2(:, 2);
% % -- MAKE TEMPERATURE RELATIVE, T1=0 --
% y1TempDelta = dataPulse1(:, 2) - dataPulse1(1, 2);
%     dataPulse1 = [x1, y1TempDelta];
%         x1 = dataPulse1(:,1);
%         y1 = dataPulse1(:,2);
% y2TempDelta = dataPulse2(:, 2) - dataPulse2(1, 2);
%     dataPulse2 = [x2, y2TempDelta];
%         x2 = dataPulse2(:,1);
%         y2 = dataPulse2(:,2);
% % -- WRITE NEW FILES IN THEIR OWN DIRECTORIES -- 
% newdir = strcat(specificdir,'_Adjusted');
%     mkdir(newdir);
% headerFileName=strcat(newdir,filelist(i).name,'_Header.txt');
% fileID = fopen(headerFileName, 'w')
% %     writetable(headerData,headerFileName);
%     fprintf(fileID,'%s');
%     fclose(fileID);
% % newFileName1 = strcat(newdir,filelist(i).name,'_Pulse1',ext);
% %     csvwrite(newFileName1,dataPulse1);
% % newFileName2 = strcat(newdir,filelist(i).name,'_Pulse2',ext);
% %     csvwrite(newFileName2,dataPulse2);
% % movefile(headerFileName,newdir);
% % movefile(newFileName1,newdir);
% % movefile(newFileName2,newdir);
% 
% %  fprintf(fid, '%s,', c{1,1:end-1}) ;
% %  fprintf(fid, '%s\n', c{1,end}) ;
% %  dlmwrite('test.csv', c(2:end,:), '-append') ;
    fclose(fid);
end
