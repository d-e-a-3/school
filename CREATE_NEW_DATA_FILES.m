headerFileName=strcat(name,'_header');
newFileName1 = strcat(name,'_Pulse1',ext);
newFileName2 = strcat(name,'_Pulse2',ext);
writetable(headerData,headerFileName);
csvwrite(newFileName1,dataPulse1);
csvwrite(newFileName2,dataPulse2);
% Move common files to their unique directory
    newdir = strcat(subdirstr,filelist(i).name,'_Adjusted_');
    mkdir(newdir);
    movefile(headerFileName,newdir);
    movefile(newFileName1,newdir);
    movefile(newFileName2,newdir);
%     movefile(plotFileName,newdir);