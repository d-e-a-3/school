%
% Read original .csv data file.
% Separate pulses based on timing, where 
%  the number of pulses in a data file is given in the # Bursts field in
%  the Header, where rows 0-18 contain Header and variable data,
%       and rows:
%       19 to (end-19)/#Bursts contain the first pulse data,
%       (end-19)/#Bursts to 2*(end-19)/#Bursts+19 contain Pulse 2 data,
%       2*(end-19)/#Bursts+19 to end contain Pulse 3 data, if present.
% Remove leading zeros to improve fitting results,
% Adjust for Delta t,
% Adjust for Delta T, 
% Identify thermistor self-heating effect via its more rapid Delta T via discontinuity in diff() or diff(diff()),
% Remove thermistor self-heating effect, 
% Redefine Delta T for tissue heating only,
% Perform double exponential fit on this leading edge to determine T(lambda, Power Density).
% Write individual files for separated pulses, including header data.
% Move files to a new directory to keep things clean.
% 
% 
clearvars
basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements/PMI Data/PMI';
datadir = '/pig1/'; % All data in separate folders within basedir/.
datafiletype = '*.csv'; % *.csv format used for LabVIEW results.
specificdir = strcat(basedir, datadir);
subdirstr = strcat(specificdir, datafiletype);
filelist = dir(subdirstr);
numfiles = length(filelist);
[pathstr, name, ext] = fileparts(subdirstr);
endHeaderRow = 18;
for i = 1:3%numfiles
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
line5 = fgets(fid); %Fiber id
line6 = fgets(fid); %Power (percent)
    power = sscanf(line6, ['Power (percent),' '%d'])';
line7 = fgets(fid); %On time(ms)
line8 = fgets(fid); %Off time(ms)
line9 = fgets(fid); %# Pulses
    pulses = sscanf(line9, ['# Pulses,' '%d'])';
line10 = fgets(fid); %Wait Time(ms)
line11 = fgets(fid); %# Bursts
    bursts = sscanf(line11, ['# Bursts,' '%d'])';
line12 = fgets(fid); %Log Time (sec)
    logtime = sscanf(line12, ['Log time (sec),' '%d'])';
line13 = fgets(fid); %Animal ID
line14 = fgets(fid); %Probe ID
    probeID = line14;
line15 = fgets(fid); %Probe X(mm)
line16 = fgets(fid); %Probe Y(mm)
line17 = fgets(fid); %Probe Z(mm)
    posX = sscanf(line15, ['Probe X (mm),' '%d'])';
    posY = sscanf(line16, ['Probe Y (mm),' '%d'])';
    posZ = sscanf(line17, ['Probe Z (mm),' '%d'])';
% -- Define plot colors w.r.t. laser wavelength -- 
if color == 1
	datacolor = ':b';
	fitcolor = 'b';
elseif color == 2
	datacolor = ':g';
	fitcolor = 'g';
elseif color == 0
	datacolor = ':r';
	fitcolor = 'r';
else 
    datacolor = ':k';
	fitcolor = 'k';
end
% -- Define power delivered to tissue for each different probe used. -- 
if strfind(probeID,'NewRedOne')
     if power >= 30 && power <= 50;
            pulsePower = 20; %mW
     elseif power >= 15 && power < 30;
            pulsePower = 10;
     elseif power > 5 && power < 15;
            pulsePower = 5;
     elseif power <= 5;
            pulsePower = 2;
     else disp('Trouble, Hoss.')
     end
elseif strfind(probeID,'Red') | strfind(probeID,'red')
     if power >= 70 && power <= 90;
            pulsePower = 20; %mW
     elseif power >= 35 && power < 70;
            pulsePower = 10;
     elseif power > 15 && power < 35;
            pulsePower = 5;
     elseif power <= 15;
            pulsePower = 2;
     else disp('Razzum Frazzum.')
     end    
elseif strfind(probeID,'OF') | strfind(probeID,'prob#1')
     if power >= 70 && power <= 90;
            pulsePower = 28; %mW
     elseif power >= 35 && power < 70;
            pulsePower = 14.5;
     elseif power > 15 && power < 35;
            pulsePower = 7.3;
     elseif power <= 15;
            pulsePower = 3;
     else disp('I''m not even supposed to be here today.')
     end
else pulsePower = 1;
end
% -- SEPARATE PULSES -- Make into an if-elseif statement?
numRows = size(T,1);
endPulse1Row = round((numRows - endHeaderRow)/bursts + endHeaderRow,0);
    dataPulse1 = str2double(T{endHeaderRow+1:endPulse1Row,:});
        x1 = dataPulse1(:,1);
        y1 = dataPulse1(:,2);       
endPulse2Row = round(2*(numRows - endHeaderRow)/bursts + endHeaderRow,0);
    dataPulse2 = str2double(T{endPulse1Row:endPulse2Row,:});
        x2 = dataPulse2(:,1);
        y2 = dataPulse2(:,2);
    dataPulse3 = str2double(T{endPulse2Row:numRows,:});
        x3 = dataPulse3(:,1);
        y3 = dataPulse3(:,2);     
% -- MAKE TIME RELATIVE, t1=0 --  Make into an if-elseif statement?      
x1TimeShifted = dataPulse1(:, 1) - dataPulse1(1,1);
    dataPulse11 = [x1TimeShifted,y1];
        x11 = dataPulse11(:,1);
        y11 = dataPulse11(:,2);     
x2TimeShifted = dataPulse2(:,1) - dataPulse2(1,1);
    dataPulse21 = [x2TimeShifted,y2];
        x21 = dataPulse21(:,1);
        y21 = dataPulse21(:,2);     
x3TimeShifted = dataPulse3(:,1) - dataPulse3(1,1);
    dataPulse31 = [x3TimeShifted,y3];
        x31 = dataPulse31(:,1);
        y31 = dataPulse31(:,2); 
% -- MAKE TEMPERATURE RELATIVE, T1=0 --  Make into an if-elseif statement?
y1TempDelta = dataPulse11(:,2) - dataPulse11(1,2);
    dataPulse12 = [x11,y1TempDelta];
        x12 = dataPulse12(:,1);
        y12 = dataPulse12(:,2);
y2TempDelta = dataPulse21(:,2) - dataPulse21(1,2);
    dataPulse22 = [x21,y2TempDelta];
        x22 = dataPulse22(:,1);
        y22 = dataPulse22(:,2);
y3TempDelta = dataPulse31(:,2) - dataPulse31(1,2);
    dataPulse32 = [x31,y3TempDelta];
        x32 = dataPulse32(:,1);
        y32 = dataPulse32(:,2);
% % -- ISOLATE TEMP RISE, Scrape-off preliminary T = 0 data --
thresholdTempRise = 0.005;   % this can be tweaky.  me no likey.
differenceLocation1 = diff(y12); 
% plot(differenceLocation1)
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
% RateDifferenceLocation = diff(differenceLocation2);
% FindRDL = find(RateDifferenceLocation);
% doubleDifferenceLocation = find(RateDifferenceLocation==max(abs(RateDifferenceLocation)));
% % semilogy(differenceLocation2,'b')
% % hold on
% semilogy(FindRDL,'k')
% hold on
% semilogy(y22,':r')
% AAAA = dataPulse22(FindRDL,:);
% % plot(AAAA(:,1),AAAA(:,2))
% RateDifferenceLocationAAAA = diff(AAAA(:,2));
% FindRDLAAAA = find(RateDifferenceLocationAAAA,1);
% NewAAAA=AAAA(FindRDLAAAA,:)
% plot(RateDifferenceLocation)
% xlim([0 200])
% % doubleDifferenceLocationAAAA = find(RateDifferenceLocationAAAA==max(abs(RateDifferenceLocationAAAA)));
% % matrixPoo = [dataPulse23, differenceLocation2]
% % sparseyPoo = nonzeros(matrixPoo);
% % %                 plot(x13,y13,x23,y23)
% % %                     hold on
% -- FIT CURVES -- using "exponential_fit_test.m"
[f1,gof1] = fit(x13,y13/pulsePower,'exp2');
[f2,gof2] = fit(x23,y23/pulsePower,'exp2');
plot(x13,y13/pulsePower,datacolor)
    xlim([0 30]);
    xlabel('time (s)');
    ylabel('Temp. (°C)');
%     legend('off')    
 	legend({'$P_1$ Data',sprintf('$T_{P1} = %3.4fe^{(%1.2ex)}+%3.4fe^{(%1.2ex)}$',f1.a,f1.b,f1.c,f1.d),'$P_2$ Data',sprintf('$T_{P2} = %3.4fe^{(%1.2ex)}+%3.4fe^{(%1.2ex)}$',f2.a,f2.b,f2.c,f2.d)},'Location','southeast','Interpreter','latex'); 
    title(filelist(i).name,'Interpreter','none');
    hold all
formula(f1);
formula(f2);
ci1 = predint(f1,x13);
ci2 = predint(f2,x23);
plot(f1,fitcolor)  
    legend('off') 
plot(x23,y23/pulsePower,datacolor)
plot(f2,fitcolor)  
    legend('off') 
% % % 	plotFileName = strcat(filelist(i).name, '_plot.pdf');
% % %     	saveas(gcf, fullfile(plotFileName),'pdf');
% % % hold off
% % % 
% % % % -- WRITE NEW DATA FILES AND SAVE IN THEIR OWN DIRECTORIES -- 
% % % headerData = T{1:endHeaderRow-1,:};
% % % newdir = strcat(specificdir,'Adjusted_Data'); 
% % % mkdir(newdir);
% % % headerFileName=strcat(newdir,filelist(i).name,'_Header.txt');
% % % pulse1File=strcat(newdir,filelist(i).name,'_Pulse1.txt');
% % % pulse2File=strcat(newdir,filelist(i).name,'_Pulse2.txt');
% % % % write header and data
% % % % x3 = str2double(x1);
% % % writetable(cell2table(headerData),headerFileName, 'WriteVariableNames', false);
% % % fileID = fopen(headerFileName, 'a+');
% % % fprintf(fileID, '\r\n');
% % % for k = 1:length(x1)
% % %    fprintf(fileID, '%12.6f, %6.2f\r\n', x1(k),y1(k));
% % % end
% % % movefile(plotFileName,newdir);
% % % movefile(headerFileName,newdir);
% % % % movefile(newFileName2,newdir);
% % % fclose(fileID);
fclose(fid);
end
hold off
