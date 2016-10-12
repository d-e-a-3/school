%  Fits from "Optical properties of fat emulsions"
%  https://doi.org/10.1364/OE.16.005907
clf;
wvl = linspace(400,900,50); % [nm]
% g fit
Intralipid10_g = [1.018E+0 -8.820E-4];
g_10 = Intralipid10_g(1) + Intralipid10_g(2).*wvl;
Intralipid20_g = [1.090E+0 -6.812E-4];
g_20 = Intralipid20_g(1) + Intralipid20_g(2).*wvl;
% µ_s fit [mm-1]
Intralipid10_mu_s = [4.857E+8 -2.644E+0];
mu_s_10 = Intralipid10_mu_s(1)*wvl.^Intralipid10_mu_s(2);
Intralipid20_mu_s = [3.873E+8 -2.397E+0];
mu_s_20 = Intralipid20_mu_s(1)*wvl.^Intralipid20_mu_s(2);
% calculate µ_s' from µ_s(1-g) [mm-1]
mu_s_prime_calc_10 = mu_s_10.*(1-g_10);
mu_s_prime_calc_20 = mu_s_20.*(1-g_20);
% µ_s' fit [mm-1]
Intralipid10_mu_s_prime = [4.957E+1 -9.063E-2 4.616E-5];
mu_s_prime_10 = Intralipid10_mu_s_prime(1) + Intralipid10_mu_s_prime(2)*wvl + Intralipid10_mu_s_prime(3)*wvl.^2;
Intralipid20_mu_s_prime = [8.261E+1 -1.288E-1 6.093E-5];
mu_s_prime_20 = Intralipid20_mu_s_prime(1) + Intralipid20_mu_s_prime(2)*wvl + Intralipid20_mu_s_prime(3)*wvl.^2;
% 
figure(100);
left_color = [0 0 0];
right_color = [0 0 0];
set(figure(100),'defaultAxesColorOrder',[left_color; right_color]);
yyaxis left;
semilogy(wvl,mu_s_10,'--r',wvl,mu_s_20,'--b',wvl,mu_s_prime_10,'r',wvl,mu_s_prime_20,'b');
ylabel('\mu [mm^{-1}]')
yyaxis right;
plot(wvl,g_10,'--k',wvl,g_20,'k');
ylabel('g')
xlabel('Wavelenght [nm]')
ylim([0,1]);
title('Scattering in 10% and 20% Intralipid');
legend('\mu_{s 10%}','\mu_{s 20%}','\mu_{s'' 10%}','\mu_{s'' 20%}','g_{10%}','g_{20%}');
fig = figure(100);
left_color = [.5 .5 0];
right_color = [1 1 1];
set(figure(100),'defaultAxesColorOrder',[left_color; right_color]);
