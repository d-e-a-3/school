% demoMie.m
home
disp('**** And so it begins ****')
clearvars
%
nmed =  1.56 ; % medium refractive index (epoxy)
npar =  1.1 ; % particle refractive index (hollow whatever)
fv   = 0.01; % volume fraction of spheres in medium
% lambda = 635/1000; % [um]
lambdalambda = [488,532,635]'/1000; % [µm]
diadia = logspace(-1,1,500)'; % [um]
musgp = zeros(length(lambdalambda),length(diadia),3);
for j=1:length(diadia)
    dia = diadia(j);
for i=1:length(lambdalambda)
        lambda = lambdalambda(i);
        musgp(i,j,:) = getMieScatter(lambda, dia, fv, npar,nmed);
    end % i 
end
% plot results
figure(101)
clr = 'rbgk';
sz  = 10;
yname(1).s = '\mu_s [mm^{-1}]';
yname(2).s = 'g';
yname(3).s = '\mu_{s}^{''} [mm^{-1}]';
ymax = [50 1 10];
for k=1:3
    subplot(3,1,k)
    if k==1
            plot(diadia,musgp(i,:,k)/10,[clr(i) '.'])
            ylim([0 ymax(k)])
            legend(sprintf('n_{med} = %0.2f , n_{par} = %0.2f , lambda = %0.0f nm',nmed,npar,lambda*1000))
        elseif k==2
            plot(diadia,musgp(i,:,k),'.r')
            ylim([0 ymax(k)])
        else
            plot(diadia, musgp(i,:,k)/10,'.r')
            ylim([0 ymax(k)])
    end
    set(gca,'fontsize',sz)
%     xlabel('wavelength \lambda [nm]')
    xlabel('Ø_{sphere} [µm]')
    ylabel(yname(k).s)
    xlim([0 5])
end
disp('**** It''s in the hole. ****')
