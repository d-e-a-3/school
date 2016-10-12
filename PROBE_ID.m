if strfind(probeID,'NewRedOne')>0;
     if power >= 30;
            pulsePower = 20; %mW
     elseif power >= 15 & power < 30;
            pulsePower = 10;
     elseif power > 5 & power < 15;
            pulsePower = 5;
     elseif power <= 5;
            pulsePower = 2;
     else disp('Trouble, Hoss.')
     end
elseif strfind(probeID,'ed')>0; 
     if power >= 70;
            pulsePower = 20; %mW
     elseif power >= 35 & power < 70;
            pulsePower = 10;
     elseif power > 15 & power < 35;
            pulsePower = 5;
     elseif power <= 15;
            pulsePower = 2;
     else disp('Razzum Frazzum.')
     end    
elseif strfind(probeID,'OF')>0; 
    if power >= 70;
            pulsePower = 28; %mW
     elseif power >= 35 & power < 70;
            pulsePower = 14.5;
     elseif power > 15 & power < 35;
            pulsePower = 7.3;
     elseif power <= 15;
            pulsePower = 3;
     else disp('I''m not even supposed to be here today.')
    end
elseif strfind(probeID,'prob')>0; 
    if power >= 70;
            pulsePower = 28; %mW
     elseif power >= 35 & power < 70;
            pulsePower = 14.5;
     elseif power > 15 & power < 35;
            pulsePower = 7.3;
     elseif power <= 15;
            pulsePower = 3;
     else disp('HUH?!!?!')
    end
elseif strfind(probeID,'Therm')>0; 
    if power >= 42;
            pulsePower = 20; %mW
     elseif power >= 21 & power < 42;
            pulsePower = 10;
     elseif power > 6 & power < 21;
            pulsePower = 5;
     elseif power <= 6;
            pulsePower = 2;
     else disp('Why are you dong this to me?')
    end
elseif strfind(probeID,'NEW RED ONE')>0; 
    if power >= 42;
            pulsePower = 20; %mW
     elseif power >= 21 & power < 42;
            pulsePower = 10;
     elseif power > 10 & power < 21;
            pulsePower = 5;
     elseif power <= 9;
            pulsePower = 2;
     else disp('NEW RED ONE?')
    end
else if power >= 70;
            pulsePower = 20; %mW
     elseif power >= 35 & power < 70;
            pulsePower = 10;
     elseif power > 15 & power < 35;
            pulsePower = 5;
     elseif power <= 15;
            pulsePower = 2;
     else disp('something is wrong with Probe ID')
    end
end