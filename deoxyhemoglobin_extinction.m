% ***********************************************************************
% deoxyhemoglobin_extinction.m
% ***********************************************************************
%
% Data description:
% The molar extinction coefficient of deoxyhemoglobin in 
% [cm^-1 (moles/l)^-1] (250 - 1000nm) with a resolution of 5nm:
%
% Prepared by: Daniel Yim on December 2011
%
% ***********************************************************************
%
% Original data source:
%     S. Prahl. Optical absorption of hemoglobin. Tech. rep., Oregon 
%     Medical Laser Center, Portland, Oregon, U.S.A, 1999
%     [http://omlc.ogi.edu/spectra/hemoglobin/index.html]
%
% ***********************************************************************
M = [ ...
250.0, 112700.0; ...
255.0, 113250.0; ...
260.0, 116300.0; ...
265.0, 119550.0; ...
270.0, 122900.0; ...
275.0, 121400.0; ...
280.0, 118900.0; ...
285.0, 113400.0; ...
290.0, 98360.0; ...
295.0, 81460.0; ...
300.0, 64440.0; ...
305.0, 57870.0; ...
310.0, 59160.0; ...
315.0, 66825.0; ...
320.0, 74510.0; ...
325.0, 83825.0; ...
330.0, 90860.0; ...
335.0, 97660.0; ...
340.0, 108500.0; ...
345.0, 114800.0; ...
350.0, 122100.0; ...
355.0, 130450.0; ...
360.0, 134900.0; ...
365.0, 137450.0; ...
370.0, 140000.0; ...
375.0, 142750.0; ...
380.0, 145200.0; ...
385.0, 151300.0; ...
390.0, 167800.0; ...
395.0, 196800.0; ...
400.0, 223300.0; ...
405.0, 261950.0; ...
410.0, 304000.0; ...
415.0, 353200.0; ...
420.0, 407600.0; ...
425.0, 471500.0; ...
430.0, 528600.0; ...
435.0, 549600.0; ...
440.0, 413300.0; ...
445.0, 259950.0; ...
450.0, 103300.0; ...
455.0, 33435.0; ...
460.0, 23390.0; ...
465.0, 18700.0; ...
470.0, 16160.0; ...
475.0, 14920.0; ...
480.0, 14550.0; ...
485.0, 15375.0; ...
490.0, 16680.0; ...
495.0, 18650.0; ...
500.0, 20860.0; ...
505.0, 23285.0; ...
510.0, 25770.0; ...
515.0, 28680.0; ...
520.0, 31590.0; ...
525.0, 35170.0; ...
530.0, 39040.0; ...
535.0, 42840.0; ...
540.0, 46590.0; ...
545.0, 50490.0; ...
550.0, 53410.0; ...
555.0, 54530.0; ...
560.0, 53790.0; ...
565.0, 49700.0; ...
570.0, 45070.0; ...
575.0, 40905.0; ...
580.0, 37020.0; ...
585.0, 33590.0; ...
590.0, 28320.0; ...
595.0, 21185.0; ...
600.0, 14680.0; ...
605.0, 12040.0; ...
610.0, 9444.0; ...
615.0, 7553.5; ...
620.0, 6510.0; ...
625.0, 5763.5; ...
630.0, 5149.0; ...
635.0, 4666.5; ...
640.0, 4345.0; ...
645.0, 4026.5; ...
650.0, 3750.0; ...
655.0, 3481.5; ...
660.0, 3227.0; ...
665.0, 3011.0; ...
670.0, 2795.0; ...
675.0, 2591.0; ...
680.0, 2408.0; ...
685.0, 2224.5; ...
690.0, 2052.0; ...
695.0, 1923.5; ...
700.0, 1794.0; ...
705.0, 1661.0; ...
710.0, 1540.0; ...
715.0, 1432.5; ...
720.0, 1326.0; ...
725.0, 1224.0; ...
730.0, 1102.0; ...
735.0, 1102.0; ...
740.0, 1116.0; ...
745.0, 1236.5; ...
750.0, 1405.0; ...
755.0, 1551.0; ...
760.0, 1549.0; ...
765.0, 1435.5; ...
770.0, 1312.0; ...
775.0, 1188.5; ...
780.0, 1075.0; ...
785.0, 977.04; ...
790.0, 890.79; ...
795.0, 815.89; ...
800.0, 761.70; ...
805.0, 733.70; ...
810.0, 717.10; ...
815.0, 703.95; ...
820.0, 693.79; ...
825.0, 693.39; ...
830.0, 693.00; ...
835.0, 692.70; ...
840.0, 692.39; ...
845.0, 691.89; ...
850.0, 691.29; ...
855.0, 690.75; ...
860.0, 694.29; ...
865.0, 698.95; ...
870.0, 705.79; ...
875.0, 716.15; ...
880.0, 726.39; ...
885.0, 734.90; ...
890.0, 743.60; ...
895.0, 752.70; ...
900.0, 761.79; ...
905.0, 768.59; ...
910.0, 774.60; ...
915.0, 778.20; ...
920.0, 777.39; ...
925.0, 774.50; ...
930.0, 763.79; ...
935.0, 730.25; ...
940.0, 693.39; ...
945.0, 650.79; ...
950.0, 602.20; ...
955.0, 561.70; ...
960.0, 525.60; ...
965.0, 484.35; ...
970.0, 429.30; ...
975.0, 395.80; ...
980.0, 359.69; ...
985.0, 321.45; ...
990.0, 283.19; ...
995.0, 245.05; ...
1000.0, 206.8];

% semilogy(M(:,1), M(:,2), 'b', 'linewidth',1.5);
% set(gca,'FontSize',14);
% ylabel('molar extinction coefficient (cm^{-1}/(mol/L))','fontsize',14);
% xlabel('wavelength (nm)','fontsize',14);
% axis([250 1000 0 10^6]);
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 6 5]);
% title('Deoxygenated hemoglobin','FontSize',14);
% grid on;
% 
% pause;
% print -dpng deoxyhemoglobin_extinction.png -r100
% close;
 
