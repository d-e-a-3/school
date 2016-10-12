s1='/Users/dan_andersen/Desktop/'; % set project dir
s2='Blue laser stability check/'; % set specific directory
s3='760767_01.txt';  %  file
    s=char([s1 s2 s3]);
Array1=dlmread(s,'\t',17,0);
    col11 = Array1(:, 1);
    col21 = Array1(:, 2);
    numel(col11)
p1=plot(col11, col21,'bo');
    title(s2)
    xlabel('t (s)')
    ylabel('P (W)')
    % xlim([1000 2000])
    % ylim([0.028 0.03])
    grid on
    hold on

windowSize = 10;
a=1;
b = (1/windowSize)*ones(1,windowSize);
y=filter(b,a,col21);

p3=plot(col11, y,'r');
hold off

% s4='760767_02.txt';  %  file
%     s5=char([s1 s2 s4]);
% Array2=dlmread(s5,'\t',17,0);
%     col12 = Array2(:, 1);
%     col22 = Array2(:, 2);
% p2=plot(col12, col22,'b--');
% p2.LineWidth = 2;
% saveas(gcf, 'plot', 'pdf')
% hold off