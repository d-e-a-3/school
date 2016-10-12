clearvars
basedir = '/Users/dan_andersen/Dropbox/PD Pre-IDE';
spdir = '/Device Description/';
filetype = 'vol comparison data.csv';
dirstr = strcat(basedir, spdir, filetype);
filelist = dir(dirstr);
numfiles = length(filelist);
[pathstr, name, ext] = fileparts(dirstr);

    dataPulse1 = csvread(dirstr, 2,0,[2  0 61 3]);
        x1 = dataPulse1(:, 1);
        y1 = dataPulse1(:, 2);  
        y2 = dataPulse1(:, 3);
        y3 = dataPulse1(:, 4);
  
    semilogy(x1, y1,':k', 'LineWidth',2);
            ylabel('Illuminated Volume (mm^3)');
            xlabel('Threshold Irradiance (mW/mm^2)');
            xlim([0 10]);
            ylim([0.1 1000]);
            grid on;
            hold on

    plotFileName = strcat(pathstr,'/', 'plot1.pdf');
    saveas(gcf, fullfile(plotFileName), 'pdf');    

    loglog(x1, y2, ':b', 'LineWidth',2);
            ylabel('Illuminated Volume (mm^3)');
            xlabel('Threshold Irradiance (mW/mm^2)');
            xlim([0.1 10]);
            ylim([0.1 1000]);
            grid on;
            hold on
    plotFileName = strcat(pathstr,'/', 'plot2.pdf');
    saveas(gcf, fullfile(plotFileName), 'pdf');   

    loglog(x1, y3, 'r-', 'LineWidth',2);
            ylabel('Illuminated Volume (mm^3)');
            xlabel('Threshold Irradiance (mW/mm^2)');
            xlim([0 10]);
            ylim([0.1 1000]);
            grid on;
    plotFileName = strcat(pathstr,'/', 'plot3.pdf');
    saveas(gcf, fullfile(plotFileName), 'pdf');
    hold off