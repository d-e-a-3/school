%
% Read original .csv data file.
% Separate pulses based on timing, where rows:
%       0-18        contain Header and variable data,
%       19-half     contain Pulse 1 data,
%       half-end    contain Pulse 2 data.
% Adjust for ?t.
% Adjust for ?T, trim off 
% Rename and Save file with _PulseX extension, where X = original pulse #,
%   including all original header data.
% Move files to a new directory to keep things clean.
% 
clearvars
basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements/PMI Data/PMI';
datadir = '/Pig1/'; % All data in separate folders within basedir/.
datafiletype = '*.csv'; % *.csv format used for LabVIEW results.
specificdir = strcat(basedir, datadir);
subdirstr = strcat(specificdir, datafiletype);
filelist = dir(subdirstr);
numfiles = length(filelist);
[pathstr, name, ext] = fileparts(subdirstr);
endHeaderRow = 18;
for i = 1 : 12 %numfiles
filename = strcat(pathstr,'/', filelist(i).name);
    fid = fopen(filename, 'rt');
    delimiterIn = ',';
% -- EXTRACT HEADER DATA --
T = readtable(filename,'Delimiter',',','ReadVariableNames',false);
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
    probeID =  sscanf(line14, ['Probe ID' '%s'])';
line15 = fgets(fid); %Probe X(mm)
line16 = fgets(fid); %Probe Y(mm)
line17 = fgets(fid); %Probe Z(mm)
    posX = sscanf(line15, ['Probe X (mm),' '%d'])';
    posY = sscanf(line16, ['Probe Y (mm),' '%d'])';
    posZ = sscanf(line17, ['Probe Z (mm),' '%d'])';
if color == 1
     datacolor = ':b';
     fitcolor = 'b';
        if power == 90
            pulsePower = 20; %mw
        elseif power == 50
            pulsePower = 10;
        elseif power == 25
            pulsePower = 5;
        elseif power == 10
            pulsePower = 2;
        else disp('HUH?!?')
        end
    elseif color == 2
    datacolor = ':g';
    fitcolor = 'g';
        if power == 75
            pulsePower = 20; %mw
        elseif power == 37
            pulsePower = 10;
        elseif power == 18
            pulsePower = 5;
        elseif power == 7
            pulsePower = 2;
        else disp('HUH?!?')
        end
    elseif color == 0
    datacolor = ':r';
    fitcolor = 'r';
        if power == 90
            pulsePower = 20; %mw
        elseif power == 45
            pulsePower = 10;
        elseif power == 23
            pulsePower = 5;
        elseif power == 9
            pulsePower = 2;
        else disp('HUH?!?')
        end
    else if color == 1
    datacolor = ':b';
    fitcolor = 'b';
        if power == 90
        pulsePower = 27; %mw
        elseif power == 50
        pulsePower = 15;
        elseif power == 25
        pulsePower = 7.48;
        elseif power == 10
        pulsePower = 2.9;
        else disp('HUH?!?')
        end
    elseif color == 2
    datacolor = ':g';
    fitcolor = 'g';
        if power == 75
        pulsePower = 29.24; %mw
        elseif power == 37
        pulsePower = 14.54;
        elseif power == 18
        pulsePower = 7.31;
        elseif power == 7
        pulsePower = 3;
        else disp('HUH?!?')
        end
    elseif color == 0
    datacolor = ':r';
    fitcolor = 'r';
        if power == 90
        pulsePower = 28.5; %mw
        elseif power == 45
        pulsePower = 14.3;
        elseif power == 23
        pulsePower = 7.25;
        elseif power == 9
        pulsePower = 2.82;
        else disp('HUH?!?')
        end
    else disp('HUH?!?') 
        end
end
% -- SEPARATE PULSES --
numRows = size(T,1);
endPulse1Row = round((numRows - endHeaderRow)/2 + endHeaderRow,0);
    dataPulse1 = str2double(T{endHeaderRow+1:endPulse1Row,:});
        x1 = dataPulse1(:,1);
        y1 = dataPulse1(:,2);       
    dataPulse2 = str2double(T{endPulse1Row:numRows,:});
        x2 = dataPulse2(:,1);
        y2 = dataPulse2(:,2);
% -- MAKE TIME RELATIVE, t1=0 --        
x1TimeShifted = dataPulse1(:, 1) - dataPulse1(1,1);
    dataPulse11 = [x1TimeShifted,y1];
        x11 = dataPulse11(:,1);
        y11 = dataPulse11(:,2);     
x2TimeShifted = dataPulse2(:,1) - dataPulse2(1,1);
    dataPulse21 = [x2TimeShifted,y2];
        x21 = dataPulse21(:,1);
        y21 = dataPulse21(:,2);     
% -- MAKE TEMPERATURE RELATIVE, T1=0 --
y1TempDelta = dataPulse11(:,2) - dataPulse11(1,2);
    dataPulse12 = [x11,y1TempDelta];
        x12 = dataPulse12(:,1);
        y12 = dataPulse12(:,2);
y2TempDelta = dataPulse21(:,2) - dataPulse21(1,2);
    dataPulse22 = [x21,y2TempDelta];
        x22 = dataPulse22(:,1);
        y22 = dataPulse22(:,2);
% % -- ISOLATE TEMP RISE, Scrape-off preliminary T = 0 data --
thresholdTempRise = 0.015;   % this can be tweaky.  me no likey.
differenceLocation1 = diff(y12); 
plot(differenceLocation1)
xlim([0 100]);
    tempRiseStart1=find(differenceLocation1>thresholdTempRise,1);
        xScraped1 = dataPulse12(tempRiseStart1+1:round(numRows/4),1)-dataPulse12(tempRiseStart1+1,1);
        yScraped1 = dataPulse12(tempRiseStart1+1:round(numRows/4),2)-dataPulse12(tempRiseStart1+1,2);
            dataPulse13 = [xScraped1,yScraped1];
        x13 = dataPulse13(:,1);
        y13 = dataPulse13(:,2);
differenceLocation2 = diff(y22); 
        tempRiseStart2=find(differenceLocation2>thresholdTempRise,1);
        xScraped2 = dataPulse22(tempRiseStart2+1:round(numRows/4),1)-dataPulse22(tempRiseStart2+1,1);
        yScraped2 = dataPulse22(tempRiseStart2+1:round(numRows/4),2)-dataPulse22(tempRiseStart2+1,2);
            dataPulse23 = [xScraped2,yScraped2];
        x23 = dataPulse23(:,1);
        y23 = dataPulse23(:,2);   
%                 plot(x13,y13,x23,y23)
%                     hold on
% -- FIT CURVES -- using "exponential_fit_test.m"
[f1,gof1] = fit(x13,y13,'exp2');
[f2,gof2] = fit(x23,y23,'exp2');
plot(x13,y13,datacolor)
    xlim([0 30]);
    title(filelist(i).name,'Interpreter','none');
        hold on
formula(f1);
formula(f2);
ci1 = predint(f1,x13);
ci2 = predint(f2,x23);
plot(f1,fitcolor)
plot(x23,y23,datacolor)
plot(f2,fitcolor)
    xlabel('time (s)');
    ylabel('Temp. (°C)');
 	legend({'$P_1$ Data',sprintf('$T_{P1} = %3.4fe^{(%1.2ex)}+%3.4fe^{(%1.2ex)}$',f1.a,f1.b,f1.c,f1.d),'$P_2$ Data',sprintf('$T_{P2} = %3.4fe^{(%1.2ex)}+%3.4fe^{(%1.2ex)}$',f2.a,f2.b,f2.c,f2.d)},'Location','southeast','Interpreter','latex');
        hold on
% 	plotFileName = strcat(filelist(i).name, '_plot.pdf');
%     	saveas(gcf, fullfile(plotFileName),'pdf');
% hold off
% 
% % -- WRITE NEW DATA FILES AND SAVE IN THEIR OWN DIRECTORIES -- 
% headerData = T{1:endHeaderRow-1,:};
% newdir = strcat(specificdir,'Adjusted_Data'); 
% mkdir(newdir);
% headerFileName=strcat(newdir,filelist(i).name,'_Header.txt');
% pulse1File=strcat(newdir,filelist(i).name,'_Pulse1.txt');
% pulse2File=strcat(newdir,filelist(i).name,'_Pulse2.txt');
% % write header and data
% % x3 = str2double(x1);
% writetable(cell2table(headerData),headerFileName, 'WriteVariableNames', false);
% fileID = fopen(headerFileName, 'a+');
% fprintf(fileID, '\r\n');
% for k = 1:length(x1)
%    fprintf(fileID, '%12.6f, %6.2f\r\n', x1(k),y1(k));
% end
% movefile(plotFileName,newdir);
% movefile(headerFileName,newdir);
% % movefile(newFileName2,newdir);
% fclose(fileID);
end
hold off
