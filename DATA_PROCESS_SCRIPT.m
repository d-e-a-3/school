%
% CALLS SCRIPTS TO: 
% PARSE DATA TO SEPERATE PULSES AND EXTRACT HEADER INFO
% ADJUST TIME BASE FOR T1=0 FOR EACH PULSE
% ADJUST FOR DELTA T FOR EACH PULSE
% SAVE INDIVIDUAL DATA FILES
% PLOT EACH SIMILAR PULSE IN A SINGLE GRAPH AND SAVE IT AS A LABLED PDF
% 
%
clearvars
basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements/Test Data';
spdir = '/Intralipid/';
datafiletype = '*.csv';
subdirstr = strcat(basedir, spdir);
dirstr = strcat(subdirstr, datafiletype);
filelist = dir(dirstr);
numfiles = length(filelist)
[pathstr, name, ext] = fileparts(dirstr);
endHeaderRow = 18;
for i = 1 : numfiles
    filename = strcat(pathstr,'/', filelist(i).name);
    fid = fopen(filename, 'rt');
        PULL_HEADER_DATA;
            headerFileName=strcat(pathstr, name,'_header');
                writetable(headerData, headerFileName);
        SCAN_HEADER_DATA;
        PULSE_SEPARATION;
        TIME_BASE_SHIFT;
        DELTA_T;
        CREATE_NEW_DATA_FILES;
%         CREATE_OVERLAY_PLOT;
    fclose(fid);
end
