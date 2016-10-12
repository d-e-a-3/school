% Build Array from multiple timeseries waveforms
% Find average per row
arrayOfPulses = zeros(numRows, 2*numfiles);
arrayOfPulses(0:lengthY1,i) = x1
arrayOfPulses(0:lengthY2,i+1) = x2