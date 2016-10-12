% Fiber_Mie.m
home
disp('**** And so it begins ****')
clearvars, clf;
%
nmed =  1.5 ; % medium refractive index (epoxy)
npar =  1.31 ; % particle refractive index (hollow whatever)
fv   = 0.10; % volume fraction of spheres in medium
lambdalambda = [650,532,450]'/1000; % [µm]
diadia = logspace(-1,2,500)'; % [um]
musgp = zeros(length(lambdalambda),length(diadia),3);
for i=1:length(lambdalambda)
    lambda = lambdalambda(i);
    for j=1:length(diadia)
        dia = diadia(j);
        musgp(i,j,:) = getMieScatter(lambda,dia,fv,npar,nmed);
    end % j 
end % i
% plot results
figure(101)
clr = 'rgb';
sz  = 10;
yname(1).s = '\mu_s [mm^{-1}]';
yname(2).s = 'g';
yname(3).s = '\mu_{s}^{''} [mm^{-1}]';
ymax = [200 1 10];
for k=1:3
    subplot(3,1,k)
    for i=1:length(lambdalambda)
    if k==1
            loglog(diadia,musgp(i,:,k)/10,[clr(i) '.'])
            hold on
            ylim([10^-2 10^3])
            legend(sprintf('n_{med} = %0.2f , n_{par} = %0.2f',nmed,npar))
        elseif k==2
            loglog(diadia,musgp(i,:,k),[clr(i) '.'])
            ylim([0 ymax(k)])
            y_mean = mean(diadia);
            text(y_mean,0.13*i,sprintf('lambda = %0.0f nm ', lambdalambda(i)*1000),'fontsize',sz, 'color',clr(i))
        else
            loglog(diadia, musgp(i,:,k)/10,[clr(i) '.'])
            ylim([10^-2 10^2])
    end
    hold on
    end
    set(gca,'fontsize',sz)
    xlabel('Ø_{sphere} [µm]')
    ylabel(yname(k).s)
    xlim([0 100])
end
disp('**** It''s in the hole. ****')
