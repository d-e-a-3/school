% -- Scrape-off preliminary T = 0 data --
% Assume 2 pulses, and trim to just rising edge by dividing by 4.
% thresholdTempRise can be tweaky.  me no likey.
differenceLocation1 = diff(y1); 
    tempRiseStart1=find(differenceLocation1>thresholdTempRise,1);
        xScraped1 = dataPulse1(tempRiseStart1+1:round(numRows/4),1)-dataPulse1(tempRiseStart1+1,1);
        yScraped1 = dataPulse1(tempRiseStart1+1:round(numRows/4),2)-dataPulse1(tempRiseStart1+1,2);
            dataPulse1 = [xScraped1,yScraped1];
            x1 = xScraped1;
            y1 = yScraped1;
differenceLocation2 = diff(y2); 
        tempRiseStart2=find(differenceLocation2>thresholdTempRise,1);
        xScraped2 = dataPulse2(tempRiseStart2+1:round(numRows/4),1)-dataPulse2(tempRiseStart2+1,1);
        yScraped2 = dataPulse2(tempRiseStart2+1:round(numRows/4),2)-dataPulse2(tempRiseStart2+1,2);
            dataPulse2 = [xScraped2,yScraped2];
            x2 = xScraped2;
            y2 = yScraped2;