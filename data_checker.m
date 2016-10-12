clearvars
basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements/PMI Data/PMI';
datadir = '/Pig1/'; % All data in separate folders within basedir/.
datafiletype = 'Temp Log 2016-05-11_11-49-26 (Step 12).csv'; % *.csv format used for LabVIEW results.
specificdir = strcat(basedir, datadir);
subdirstr = strcat(specificdir, datafiletype);
filelist = dir(subdirstr);
numfiles = length(filelist);
[pathstr, name, ext] = fileparts(subdirstr);
endHeaderRow = 18;
hold on
for i = 1 : 1 %numfiles
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
     datacolor = 'b';
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
    datacolor = 'g';
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
    datacolor = 'r';
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
data = str2double(T{endHeaderRow+1:end,:});
        x = data(:,1);
        y = data(:,2); 
plot(x,y,datacolor)
hold on
end
