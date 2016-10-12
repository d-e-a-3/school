%
% 1. Read original .csv data file
% 2. Separate pulses based on timing, where rows:
%       0-18        contain Header data
%       19-half     contain Pulse 1 data
%       half-end   contain Pulse 2 data
% 3. Adjust time base, s.t. 
%       t(1) = t_i(1)-t_19(1),
%       t(2) = t_i(1)-t_half(1), 
% 4. Adjust for Delta T, s.t.
%       T = T_i - T_0
% 5. Rename and Save file with _px extension, where x = original pulse #, include all original header data
% 6. Save plot of both adjusted pulses file using "modified_file_names.pdf"
% 7. Move files to a new unique directory to keep things clean(er)
% 
clearvars
basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements/Apparatus';
spdir = '/Intralipid/';
filetype = '*.csv';
dirstr = strcat(basedir, spdir, filetype);
filelist = dir(dirstr);
numfiles = length(filelist);
[pathstr, name, ext] = fileparts(dirstr);
endRowHeader = 18;
% endRowPulse1 = 3744;
% endRowPulse2 = 7523;
for i = 1 : numfiles
    filename = strcat(pathstr,'/', filelist(i).name);
    fid = fopen(filename, 'r');
%     dataSizeTest = csvread(filename,endRowHeader+1,0);
%     size(dataSizeTest)
%     endRowPulse1 = endRowHeader + size(dataSizeTest)/2:
%     endRowPulse2 = size(dataSizeTest);
% ----- NOT WORKING DUE TO NON-NUMERIC DATA IN HEADER -----
% Define HEADER
%     header = csvread(filename, 0,0,[0 0 endRowHeader 1]); 
%     
% -- FIRST PULSE --  
% separate
    dataPulse1 = csvread(filename, endRowHeader+1,0,[endRowHeader+1  0 endRowPulse1 1]);
        x1 = dataPulse1(:, 1);
        y1 = dataPulse1(:, 2);                
% set t=0          
    x1TimeShifted = dataPulse1(:, 1) - dataPulse1(1, 1);
    dataPulse1 = [x1TimeShifted,y1];
        x1 = dataPulse1(:, 1);
        y1 = dataPulse1(:, 2);     
% change to Delta T
    y1TempDelta = dataPulse1(:, 2) - dataPulse1(1, 2);
    dataPulse1 = [x1, y1TempDelta];
    newFileName1 = strcat(filename, '_P1', '.csv');
% write new data file    
        csvwrite(newFileName1, dataPulse1); 
% draw plot    
    x1 = dataPulse1(:, 1);
    y1 = dataPulse1(:, 2);
            plot(x1, y1, 'b-');
            xlabel('t (s)');
            ylabel('T (°C)');
            xlim([0 60]);
%             ylim([0 ])
            hold on;
% -- SECOND PULSE --         
% separate        
    dataPulse2 = csvread(filename, endRowPulse1,0,[endRowPulse1 0 endRowPulse2 1]);
        x2 = dataPulse2(:, 1);
        y2 = dataPulse2(:, 2);   
% set t=0          
    x2TimeShifted = dataPulse2(:, 1) - dataPulse2(1, 1);
    dataPulse2 = [x2TimeShifted,y2];
        x2 = dataPulse2(:, 1);
        y2 = dataPulse2(:, 2);
% change to Delta T
    y2TempDelta = dataPulse2(:, 2) - dataPulse2(1, 2);
    dataPulse2 = [x2, y2TempDelta];
    newFileName2 = strcat(filename, '_P2', '.csv');
% write new data file    
    csvwrite(newFileName2, dataPulse2);   
% draw plot
    x2 = dataPulse2(:, 1);
    y2 = dataPulse2(:, 2);
            plot(x2, y2, 'b--');
            hold off;
% save plots     
    plotFileName = strcat(pathstr,'/', filelist(i).name, '_plot.pdf');
    saveas(gcf, fullfile(plotFileName), 'pdf');       
 fclose(fid);
% Move files to unique directory
    newdir = strcat(basedir, spdir, 'Adjusted_', filelist(i).name);
    mkdir(newdir);
    movefile(newFileName1, newdir);
    movefile(newFileName2, newdir);
    movefile(plotFileName, newdir);
end