
%red 3D array of dimx*dimy*dimz

dimx = 201;
dimy = 201;
dimz = 201;
steps = 100;

filelist = {'/Users/dan_andersen/Engineering/PROJECTS/Parkinson''s Disease/Probes/4% 100um 3D Data sets 5July2016/single 4% 640nm 200um 10mW_Outflux.dat'};

numfiles = length(filelist);

slice = 100;

for i = 1 : numfiles
    filename = char(filelist(i));
    [pathstr, name, ext] = fileparts(filename);

    fileOrg = fopen(filename);
    A = fread(fileOrg, 201*201*201, 'double');
    fclose(fileOrg);

    
    A = reshape(A,[201, 201, 201]);
    plane = A(slice, slice, :);
    scatter3(plane)
% 
%     Contours = [0.1, 1, 10, 100]; 
%     [m Levls] = size(Contours);
%     show_plane = reshape(plane, [dimx, dimx]);
%     turn_plane = transpose(show_plane);
%     flip_plane = flipud(turn_plane);
% 
%     outputfilelist = {};
%     for powerlevel = 1 : steps %0.1mW to 10mW
% 
%         amp = powerlevel/steps;
%         disp_plane =  amp * flip_plane;
%         [C, hc] = contourf( log(625000*disp_plane), log(Contours) );
% 
%         ax = gca;
%         ax.XTick = [1 26 51 76 101 126 151 176 201 ];
%         ax.YTick = [1 26 51 76 101 126 151 176 201 ];
%         ax.XTickLabel = [ -4 -3 -2 -1 0 1 2 3 4];
%         ax.YTickLabel = [ 4 3 2 1 0 -1 -2 -3 -4];
%         xlabel('x-axis (mm)');
%         ylabel('y-axis (mm)');
% 
%         cmap = colormap(jet(Levls + 1));
%         varargin = 'vert/horizontal';
% 
%         %h_bar = colorbar('FontSize', 12, 'YTick', log(Contours), 'YTickLabel', Contours);
%         %ylabel(h_bar, 'mW/mm2');
% 
%         caxis(log([Contours(1), Contours(length(Contours))]));
%         axis equal;
%         %grid on;
% 
%         outname = sprintf('%s_%2d', name, powerlevel*steps);
%         %saveas(gca, fullfile(pathstr, outname), 'png');
%         outputfilelist{end+1} = strcat(outname, '.png');
%         set(gca, 'Color', 'none');
%         alpha(0.5);
%         export_fig(fullfile(pathstr, outname), '-png', '-transparent');
%     end
%     zipfilename = strcat(outname, '.zip');
%     zip(fullfile(pathstr, zipfilename), outputfilelist, pathstr);
end