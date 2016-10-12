    x = data(:, 1);
    y = data(:, 2);
    if color == 1
        plot(x, y, 'b');
            xlabel('t (s)')
            ylabel('T (°C)')
            xlim([0 max(x)/4])
        hold on;
    elseif color == 2
        xlim manual
        plot(x, y, 'g');
        hold on;
    elseif color == 0
        plot(x, y, 'r');
        hold off
        saveas(gcf, fullfile(pathstr, outname), 'pdf');
    else
        plot(x, y, 'y');