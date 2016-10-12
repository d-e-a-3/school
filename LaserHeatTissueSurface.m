function [dt] = laserHeatTissue(Tf,Fo,r)
%% Calculating the time required to raise the temperature of skin tissue 
% from Ti to Tf [Fahrenheit] at depth r [cm] due to incident laser power 
% at tissue surface(Fo)

% Example input: 
% Fo = .003;  % 3 mW red laser
% Tf = 98.7; [`F]
% r = 1; [cm]

Ti = 98.6; % set to initial normal body temperature 
rvec = 0:.001:r; % create vector for distance

TCi = (Ti-32)/(1.8); 
TCf = (Tf-32)/(1.8);

% Total change in Temperture in K or C
dT = TCf-TCi; %[K]

% Tissue Optical Properties 
% THESE PROPERTIES MAY VARY 
mua = .2; % tissue absorption [cm-1]
mus = 80; % tissue scattering [cm-1]
g= .9; % anisotropy 

% Tissue Material Properties
rho = 1.05; % [g/cm^3] avg tissue density
c = .85; % [cal/g*C]
f = 4.186; % [J/cal]
C = c*f; % conversion to relevant units

% Optical Prop Calculations
musp = mus.*(1-g); % reduced scattering coefficient
mueff = sqrt(3.*mua.*(mua+musp)); % effective attenuation coefficient
D = 1./(3.*(mua+musp)); % diffusion coefficient

% Fluence rate is proportional to power in Watts
F = (Fo./(4*pi.*D)).*(1./rvec).*exp(-mueff.*rvec);  % F = Fluence Rate at r = r1
                                              % Fo = Fluence Rate at r = 0.
dt = (rho.*C.*dT)./(F.*mua); % time required to raise temperature at depth,r

% Fluence Rate as a function of distance from incident light source in tissue
figure(1)
subplot(2,2,1);semilogy(rvec,F,'r-');
xlabel('depth, [cm]')
ylabel('Fluence rate [W]')
title('Fluence Rate vs Depth')
subplot(2,2,2);plot(rvec,dt,'b-');
xlabel('depth [cm]') 
ylabel('time [s]')
title('Time vs Depth [Temperature Rise]')



end