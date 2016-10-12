% demoMie.m
home
disp('**** And so it begins ****')
clearvars
%
nmed =  1.56 ; % medium refractive index (epoxy)
npar =  2.58 ; % particle refractive index (hollow whatever)
fv   = 0.01; % volume fraction of spheres in medium
lambda = 635/1000; % [um]
diadia = logspace(-1,1,200)'; % [um]
musgp = zeros(length(lambda),length(diadia),3);
for j=1:length(diadia)
    dia = diadia(j);
    musgp(:,j,:) = getMieScatter(lambda,dia,fv,npar,nmed);
end
% plot results
figure(101)
clr = 'rbgk';
sz  = 10;
yname(1).s = '\mu_s [mm^{-1}]';
yname(2).s = 'g';
yname(3).s = '\mu_{s}^{''} [mm^{-1}]';
ymax = [250 1 150];
for k=1:3
    subplot(3,1,k)
    if k==1
            plot(diadia,musgp(:,:,k)/10,[clr(j) '.'])
            ylim([0 ymax(k)])
%             legend(sprintf('n_{med} = %0.2f , n_{par} = %0.2f',nmed,npar))
        elseif k==2
            plot(diadia,musgp(:,:,k),[clr(j) '.'])
            ylim([0 ymax(k)])
        else
            plot(diadia, musgp(:,:,k)/10,[clr(j) '.'])
            ylim([0 ymax(k)])
    end
    set(gca,'fontsize',sz)
%     xlabel('wavelength \lambda [nm]')
    xlabel('Ø_{sphere} [µm]')
    ylabel(yname(k).s)
    xlim([0 5])
end
disp('**** It''s in the hole. ****')
