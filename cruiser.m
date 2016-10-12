if color == 1
	datacolor = ':b';
	fitcolor = 'b';
elseif color == 2
	datacolor = ':g';
	fitcolor = 'g';
elseif color == 0
	datacolor = ':r';
	fitcolor = 'r';
else 
    datacolor = ':k';
	fitcolor = 'k';
end

if strcmp(probeID,'NewRedOne')
     if power >= 30 && power <= 50;
            pulsePower = 20; %mW
     elseif power >= 15 && power < 30;
            pulsePower = 10;
     elseif power > 5 && power < 15;
            pulsePower = 5;
     elseif power <= 5;
            pulsePower = 2;
     else disp('Trouble, Hoss.')
     end
elseif strcmp(probeID,'Red') || strcmp(probeID,'red')
     if power >= 70 && power <= 90;
            pulsePower = 20; %mW
     elseif power >= 35 && power < 70;
            pulsePower = 10;
     elseif power > 35 && power < 15;
            pulsePower = 5;
     elseif power <= 10;
            pulsePower = 2;
     else disp('Razzum Frazzum.')
     end    
elseif strcmp(probeID,'OF') || strcmp(probeID,'prob#1')
     if power >= 70 && power <= 90;
            pulsePower = 28; %mW
     elseif power >= 35 && power < 70;
            pulsePower = 14.5;
     elseif power > 35 && power < 15;
            pulsePower = 7.3;
     elseif power <= 10;
            pulsePower = 3;
     else disp('I''m not even supposed to be here today.')
     end
else disp('Probe ID incorrect.');
end
