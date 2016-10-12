%
% Read original .csv data file
% Extract header data and write to sep. file.
% Separate pulses based on timing, where rows:
%       0-18        contain Header data
%       19-half     contain Pulse 1 data
%       half-end   contain Pulse 2 data
% Adjust time base, s.t. 
%       t(1) = t_i(1)-t_19(1),
%       t(2) = t_i(1)-t_half(1), 
% Adjust for Delta T, s.t.
%       T = T_i - T_0
% Rename and Save file with _PulseX extension, where X = original pulse #, include all original header data
% Save plot of both adjusted pulses file using "modified_file_names.pdf"
% Move files to a new unique directory to keep things clean(er)
% 
clearvars
basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements/Test Data';
spdir = '/Intralipid/';
filetype = '*.csv';
dirstr = strcat(basedir, spdir, filetype);
filelist = dir(dirstr);
numfiles = length(filelist);
[pathstr, name, ext] = fileparts(dirstr);
endHeaderRow = 18;
for i = 1 : numfiles
    filename = strcat(pathstr,'/', filelist(i).name);
    fid = fopen(filename, 'r');
% -- Extract HEADER DATA --
    T = readtable(filename)
        numRows = size(T,1)
            endPulse1Row = round((numRows - endHeaderRow)/2 + endHeaderRow,0);
    headerData = cell2table(T{1:15,:});
        headerFileName=strcat(pathstr, name,'_header');  
    writetable(headerData, headerFileName);
% -- Extract FIRST PULSE --  
% separate pulses
    dataPulse1 = csvread(filename, endHeaderRow+1,0,[endHeaderRow+1 0 endPulse1Row 1]);
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
    newFileName1 = strcat(filename, '_Pulse1', '.csv');   
% write new data file with header data    
    writetable(dataPulse1_h, newFileName1);
% draw plot    
    x1 = dataPulse1(:, 1);
    y1 = dataPulse1(:, 2);
            plot(x1, y1, 'b-');
            xlabel('t (s)');
            ylabel('T (°C)');
            xlim([0 60]);
%             ylim([0 ])
            hold on;
% % -- Extract SECOND PULSE --         
% % separate        
%     dataPulse2 = cell2table(T{endPulse1Row:numRows,:});
%        dataPulse2_h=vertcat(headerData, dataPulse2);
%             newFileName2 = strcat(pathstr, name, '_Pulse2'); 
%         x2 = dataPulse2(:, 1);
%         y2 = dataPulse2(:, 2);   
% % set t=0          
%     x2TimeShifted = dataPulse2(:, 1) - dataPulse2(1, 1);
%     dataPulse2 = [x2TimeShifted,y2];
%         x2 = dataPulse2(:, 1);
%         y2 = dataPulse2(:, 2);
% % change to Delta T
%     y2TempDelta = dataPulse2(:, 2) - dataPulse2(1, 2);
%     dataPulse2 = [x2, y2TempDelta];
%     newFileName2 = strcat(filename, '_P2', '.csv');
% % write new data file    
%     writetable(dataPulse2_h, newFileName2);  
% % draw plot
%     x2 = dataPulse2(:, 1);
%     y2 = dataPulse2(:, 2);
%             plot(x2, y2, 'b--');
%             hold off;
% % save plots     
%     plotFileName = strcat(pathstr,'/', filelist(i).name, '_plot.pdf');
%     saveas(gcf, fullfile(plotFileName), 'pdf');       
%  fclose(fid);
% % Move common files to their unique directory
%     newdir = strcat(basedir, spdir, 'Adjusted_', filelist(i).name);
%     mkdir(newdir);
%     movefile(headerFileName, newdir);
%     movefile(newFileName1, newdir);
%     movefile(newFileName2, newdir);
%     movefile(plotFileName, newdir);
end
    
        