endPulse1Row = round((numRows - endHeaderRow)/bursts + endHeaderRow,0);
    dataPulse11 = str2double(T{endHeaderRow+1:endPulse1Row,:});    
endPulse2Row = round(2*(numRows - endHeaderRow)/bursts + endHeaderRow,0);
    dataPulse12 = str2double(T{endPulse1Row:endPulse2Row,:});
% -- MAKE TIME RELATIVE, t1=0 --  Make into an if statement?      
x1TimeShifted = dataPulse11(:,1) - dataPulse11(1,1);
x2TimeShifted = dataPulse12(:,1) - dataPulse12(1,1);
% -- MAKE TEMPERATURE RELATIVE, T1=0 --  Make into an if statement?
y1TempDelta = dataPulse11(:,2) - dataPulse11(1,2);
y2TempDelta = dataPulse12(:,2) - dataPulse12(1,2);
% -- Scrape-off preliminary T = 0 data --
% Assume 2 pulses, and trim to just rising edge by dividing by 4.
% thresholdTempRise can be tweaky.  me no likey.
differenceLocation1 = diff(y1TempDelta); 
    tempRiseStart1=find(y1TempDelta>thresholdTempRise,1);
        xScraped1 = x1TimeShifted(tempRiseStart1+1:round(numRows/4),1)-x1TimeShifted(tempRiseStart1+1,1);
        yScraped1 = y1TempDelta(tempRiseStart1+1:round(numRows/4),1)-y1TempDelta(tempRiseStart1+1,1);
            dataPulse31 = [xScraped1,yScraped1];
differenceLocation2 = diff(y2TempDelta); 
    tempRiseStart2=find(y2TempDelta>thresholdTempRise,1);
        xScraped2 = x2TimeShifted(tempRiseStart2+1:round(numRows/4),1)-x2TimeShifted(tempRiseStart2+1,1);
        yScraped2 = y2TempDelta(tempRiseStart2+1:round(numRows/4),1)-y2TempDelta(tempRiseStart2+1,1);
            dataPulse32 = [xScraped2,yScraped2];
