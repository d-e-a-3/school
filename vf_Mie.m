% vf_Mie.m
home
disp('**** And so it begins ****')
clearvars, clf;
%
nmed =  1.32 ; % medium refractive index
npar =  1.63 ; % particle refractive index
fvfv = linspace(0,.50,100); % volume fraction of spheres in medium
lambdalambda = [635,532,488]'/1000; % [µm]
dia = 1.0; % [um]
musgp = zeros(length(lambdalambda),length(fvfv),3);
for i=1:length(lambdalambda)
    lambda = lambdalambda(i);
    for j=1:length(fvfv)
        fv = fvfv(j);
        musgp(i,j,:) = getMieScatter(lambda,dia,fv,npar,nmed);
    end % j 
end % i
% plot results
figure(102)
clr = 'rgb';
sz  = 10;
yname(1).s = '\mu_s [mm^{-1}]';
yname(2).s = 'g';
yname(3).s = '\mu_{s}^{''} [mm^{-1}]';
ymax = [3000 1 300];
for k=1:3
    subplot(3,1,k)
    for i=1:length(lambdalambda)
    if k==1
            plot(fvfv,musgp(i,:,k)/10,[clr(i) '.'])
            hold on
            ylim([0 ymax(k)])
            legend(sprintf('n_{med} = %0.2f , n_{par} = %0.2f',nmed,npar))
        elseif k==2
            plot(fvfv,musgp(i,:,k),[clr(i) '.'])
            ylim([0 ymax(k)])
            y_mean = mean(fvfv);
            text(y_mean,0.13*i,sprintf('lambda = %0.0f nm ', lambdalambda(i)*1000),'fontsize',sz, 'color',clr(i))
        else
            plot(fvfv, musgp(i,:,k)/10,[clr(i) '.'])
            ylim([0 ymax(k)])
    end
    hold on
    end
    set(gca,'fontsize',sz)
    xlabel('Volume Fraction')
    ylabel(yname(k).s)
    xlim([0 .5])
end
disp('**** It''s in the hole. ****')
