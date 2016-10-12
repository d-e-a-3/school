basedir = '/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Intracranial Temperature Measurements/PMI Data/PMI';
datadir = '/pig3/'; % All data in separate folders within basedir/.
datafiletype = '*.csv'; % *.csv format used for LabVIEW results.
specificdir = strcat(basedir, datadir);
subdirstr = strcat(specificdir, datafiletype);
filename = strcat(pathstr,'/', filelist(i).name);
    fid = fopen(filename, 'rt');
    delimiterIn = ',';
SCAN_HEADER_DATA