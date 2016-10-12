line1 = fgets(fid); %space
line2 = fgets(fid); %Date
line3 = fgets(fid); %Time
    time = sscanf(line3, ['Time,' '%t'])';
line4 = fgets(fid); %scanner laser 1:blue, 2: green, 0: red
    color = sscanf(line4, ['Laser,' '%d'])';
line5 = fgets(fid); %Fiber id
line6 = fgets(fid); %Power (percent)
    power = str2double(line6(17:end));
line7 = fgets(fid); %On time(ms)
line8 = fgets(fid); %Off time(ms)
line9 = fgets(fid); %# Pulses
    pulses = str2double(line9(10:end));
line10 = fgets(fid); %Wait Time(ms)
line11 = fgets(fid); %# Bursts
    bursts = sscanf(line11, ['# Bursts,' '%d'])';
line12 = fgets(fid); %Log Time (sec)
    logtime = line12(16:end);
line13 = fgets(fid); %Animal ID
    animalID = line13(11:end);
line14 = fgets(fid); %Probe ID
    probeID = line14(10:end);
line15 = fgets(fid); %Probe X(mm)
line16 = fgets(fid); %Probe Y(mm)
line17 = fgets(fid); %Probe Z(mm)
    posX = sscanf(line15, ['Probe X (mm),' '%d'])';
    posY = sscanf(line16, ['Probe Y (mm),' '%d'])';
    posZ = sscanf(line17, ['Probe Z (mm),' '%d'])';
% Determine wavelength, prescribe colors for plot
if color == 1
    datacolor = ':b';
	fitcolor = '--b';
elseif color == 2
    datacolor = ':g';
	fitcolor = '--g';
elseif color == 0
    datacolor = ':r';
	fitcolor = '--r';
else disp('No Laser Specified.')
	datacolor = ':k';
	fitcolor = '--k';
end