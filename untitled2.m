% fill header table
headerData = T{1 : endHeaderRow-1, :};
% create directory and form ooutput file name.
newdir = strcat(specificdir,'Adjusted_Data');
mkdir(newdir);
headerFileName=strcat(newdir,'\',filelist(i).name,'_Header.txt');
% write header and dataPulse1
% combineData = [headerData ; dataPulse1];
x3 = str2double(x1);
writetable(cell2table(headerData),headerFileName, 'WriteVariableNames', false);
fileID = fopen(headerFileName, 'a+');
fprintf(fileID, '\r\n');
fprintf(fileID, 'Elapsed Time (sec),Temperature\r\n');
for k = 1 : numRows - endPulse1Row
   fprintf(fileID, '%12.6f, %6.2f\r\n', x3(k),y2(k));
end
fclose(fileID);