% Fit rising edge
% Remove falling edge to improve fit accuracy & Make Rx Porportional to Optical Power
pulseLimit = 29.85; % (s) need to truncate before 30s to avoid jittery falling edge.  
splitPoint1 = find(dataPulse1(:,1)>pulseLimit,1,'first');
splitPoint2 = find(dataPulse2(:,1)>pulseLimit,1,'first');
% Using Curve Fitting Toolbox
    fitoptions.Method = 'NonLinearLeastSquares';
    fitoptions.Algorithm = 'Levenberg-Marquardt';
    fitoptions.Robust = 'Off';  %Bisquare
% Create weigthing function.  Portion defined from end of fit pulse.
weightingPortion = 0.25;
weigthingFactor = 10;
A1 = ones(round(splitPoint1*(1-weightingPortion),0),1);
B1 = weigthingFactor*ones(round(splitPoint1*weightingPortion,0),1);
    w1 = vertcat(A1,B1);
A2 = ones(round(splitPoint2*(1-weightingPortion),0),1);
B2 = weigthingFactor*ones(round(splitPoint2*weightingPortion,0),1);
    w2 = vertcat(A2,B2);
[f1,gof1] = fit(x1,y1/pulsePower,'exp2','Exclude',dataPulse1(:,1)>pulseLimit);
[f2,gof2] = fit(x2,y2/pulsePower,'exp2','Exclude',dataPulse2(:,1)>pulseLimit);
% Store Fit Coefficients
% f1Coefficients = coeffvalues(f1);
% f2Coefficients = coeffvalues(f2);
%     coeffTable = cat(1,f1Coefficients, f2Coefficients);
%     coeffFileLocation = strcat(pathstr, '/', 'Fit Coefficients_',animalID,'_',num2str(posX),'X_',num2str(posY),'Y_',num2str(posZ),'Z','.csv');
% % dlmwrite(strcat(pathstr, '/', coeffFileLocation,'.csv'),coeffTable);
% file2Add = fopen(coeffFileLocation,'w');
% fprintf(coeffFileLocation,'%7.5 %7.5 %7.5 %7.5',f1Coefficients);
% fclose(file2Add);