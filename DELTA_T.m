% Pulse 1, change to Delta T
    y1TempDelta = dataPulse1(:, 2) - dataPulse1(1, 2);
    dataPulse1 = [x1, y1TempDelta];
%         x1 = dataPulse1(:,1);
        y1 = dataPulse1(:,2);
% Pulse 2, change to Delta T
    y2TempDelta = dataPulse2(:, 2) - dataPulse2(1, 2);
    dataPulse2 = [x2, y2TempDelta];
%         x2 = dataPulse2(:,1);
        y2 = dataPulse2(:,2);