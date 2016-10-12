

clearvars
basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements/Apparatus/';
spdir = 'Intralipid/*.csv';
dirstr = strcat(basedir, spdir);
filelist = dir(dirstr);
numfiles = length(filelist);
[pathstr, name, ext] = fileparts(dirstr);

% Move files to unique directory
    newdir = mkdir('../', 'newness');
    movefile(newFileName1, newdir);
    movefile(newFileName2, newdir);
    movefile(plotFileName, newdir);