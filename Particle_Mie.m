% Particle_Mie.m
home
disp('**** And so it begins ****')
clearvars, clf
%
nmed =  1.33 ; % medium refractive index (epoxy)
npar =  1.5 ; % particle refractive index (hollow whatever)
fv   = 0.1; % volume fraction of spheres in medium
lambdalambda = [400:1:700]'/1000; % [µm]
diadia = [1 10 20 50]'; % [µm]
% diadia = [1 5 10 30]'; % [µm]
musgp = zeros(length(lambdalambda),length(diadia),3);
for j=1:length(diadia)
    dia = diadia(j);
    for i=1:length(lambdalambda)
        lambda = lambdalambda(i);
        musgp(i,j,:) = getMieScatter(lambda,dia,fv,npar,nmed);
    end % i    
end % j
% plot results
figure(100)
clr = 'rbgk';
sz  = 10;
yname(1).s = '\mu_s [mm^{-1}]';
yname(2).s = 'g';
yname(3).s = '\mu_{s}^{''} [mm^{-1}]';
ymax = [30 1 30];
for k=1:3
    subplot(3,1,k)
    for j=1:length(diadia)
        if k==1
            semilogy(lambdalambda*1000, musgp(:,j,k)/10,[clr(j) '.'])
            hold on
            ylim([10^0 10^3])
            legend(sprintf('n_{med} = %0.2f , n_{par} = %0.2f',nmed,npar))
        elseif k==2
            plot(lambdalambda*1000, musgp(:,j,k),[clr(j) '.'])
            ylim([0 ymax(k)])
            y_mean = mean(lambdalambda);
            text(1000*y_mean,0.1*j,sprintf('dia = %0.3f um', diadia(j)),'fontsize',sz, 'color',clr(j))
        else
            semilogy(lambdalambda*1000, musgp(:,j,k)/10,[clr(j) '.'])
            ylim([10^-2 10^2])
        end
        hold on 
    end
    set(gca,'fontsize',sz)
    xlabel('\lambda [nm]')
    ylabel(yname(k).s)
end
disp('**** It''s in the hole. ****')
