% demoMie.m
%
% Demonstrate use of Maetzler's MATLAB Mie calculation.
% Plots scattering, anisotropy, and reduced scattering 
% for a range of wavelengths and range of particle diameters.
% 
home
disp('=============')
% USER CHOICES
nmed = 1.59; % medium refractive index (epoxy)
npar = 2.45; % particle refractive index (polystyrene)
fv   = 0.01; % volume fraction of spheres in medium
lambdalambda = [400:2:700]'/1000; % [µm]
diadia = [0.36 0.41 0.5]'; % [µm]
musgp = zeros(length(lambdalambda),length(diadia),3);
for j=1:length(diadia)
    dia = diadia(j);
    for i=1:length(lambdalambda)
        lambda = lambdalambda(i);
        musgp(i,j,:) = getMieScatter(lambda, dia, fv, npar,nmed);
    end % i    
end % j
% plot results
figure(100);clf
clr = 'rgb';
sz  = 14;
yname(1).s = '\mu_s [cm^{-1}]';
yname(2).s = 'g [-]';
yname(3).s = '\mu_s'' [cm^{-1}]';
ymax = [3000 1 400];
for k=1:3
    subplot(3,1,k)
    for j=1:length(diadia)
        plot(lambdalambda, musgp(:,j,k),[clr(j) '-'])
        hold on
        y = ymax(k); dy = y/10; x = mean(lambdalambda);
        text(x,y-dy*j,sprintf('dia = %0.3f um', diadia(j)), ...
            'fontsize',sz, 'color',clr(j))
    end
    set(gca,'fontsize',sz)
    xlabel('wavelength \lambda [\mum]')
    ylabel(yname(k).s)
end
disp('done')