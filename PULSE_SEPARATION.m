numRows = length(filename);
    endPulse1Row = round((numRows - endHeaderRow)/2 + endHeaderRow,0);
% -- Extract FIRST PULSE --  
    dataPulse1 = csvread(filename, endHeaderRow+1,0,[endHeaderRow+1 0 endPulse1Row 1]);
        x1 = dataPulse1(:,1);
        y1 = dataPulse1(:,2);
% -- Extract SECOND PULSE --            
    dataPulse2 = csvread(filename, endPulse1Row,0,[endPulse1Row 0 numRows 1]);
        x2 = dataPulse2(:,1);
        y2 = dataPulse2(:,2);