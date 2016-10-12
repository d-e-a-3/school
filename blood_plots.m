clf;
oxyhemoglobin_extinction;
deoxyhemoglobin_extinction;
methemoglobin_extinction;

L_635 = [
    635,0.1
    635,1000
    ];
L_473 = [
    473,0.1
    473,1000
    ];
L_488 = [
    488,0.1
    488,1000
    ];
L_515 = [
    515,0.1
    515,1000
    ];
L_532 = [
    532,0.1
    532,1000
    ];

semilogy(Mmeth(:,1), 0.00054*Mmeth(:,2), 'k', 'linewidth',1);
hold on;
semilogy(Moxy(:,1), 0.00054*Moxy(:,2), 'r', 'linewidth',1);
semilogy(M(:,1), 0.00054*M(:,2), 'b', 'linewidth',1);
legend('met','oxy','deoxy');
title('Optical Absorption of da'' Hemoglobins','FontSize',12);
set(gca,'FontSize',10);
ylabel('$\mu_a (mm^{-1})$','fontsize',10);
xlabel('$\lambda (nm)$','fontsize',10);
axis([450 700 .1 100]);
semilogy(L_635(:,1), L_635(:,2), '-r', 'linewidth',1);
semilogy(L_473(:,1), L_473(:,2), '-b', 'linewidth',1);
semilogy(L_532(:,1), L_532(:,2), '-g', 'linewidth',1);
semilogy(L_488(:,1), L_488(:,2), '--b', 'linewidth',1);
semilogy(L_515(:,1), L_515(:,2), '--g', 'linewidth',1);
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 6 5]);
grid on;
% print -dpng methemoglobin_extinction.png -r100