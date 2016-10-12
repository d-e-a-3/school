%Modeled at a length R away from object on all sides, at body temperature, 37 degrees Celsius
%Assume no heat generation or perfusion in idealized model, but ultrasound beam heats the center of the tumor at 45 degrees. Initial temperature is 37 degrees throughout sphere (only affected by the body temperature).
--------------------------------------------------------------------------
clear all
close all
clc

%tissue refers to the tumor; tissue constants
K_tissue= 0.42; %in W/m, thermal conductivity of the tissue
density_tissue = 920; %in kg/m^3, density of the tissue
specificheat_tissue= 3600; %in J/kg*degrees Celsius, specific heat of tissue, 3600 is another option from another source
diffusivity_tissue=K_tissue/(density_tissue*specificheat_tissue);

radius_tumor=0.01; %1 cm, converted to m; because tumor diameter is 2 cm, which is a early stage 2 breast cancer tumor
r_distance=radius_tumor*2;
time_total=100; %100 seconds
dr=r_distance/10; %step size in for r distance (along radius of tumor)
dt=0.1; %step size in the t direction (time in seconds)
rmesh=0:dr:r_distance; %iterates to 2X the radius of the tumor, past the tumor's surface and a distance r from the tumor surface
tmesh=0:dt:time_total; %iterates up to 100 seconds
rskip=2;
tskip=2;
number_iterations=10;
nr=length(rmesh);
nt=length(tmesh);
V=zeros(nt,nr);
for i=1:nr
 for j=1:nt
15
 for k=1:number_iterations %first ten terms of series (starts from zero below)
 Z(k)=(-16/(k*pi))*sin((k*pi*rmesh(i))/(2*radius_tumor))*exp(diffusivity_tissue*tmesh(j)*(-((k*pi)/(2*radius_tumor))^2));
 %for each radius and time iteration gets Z value
 end

 steady_state(j,i)=((-4*rmesh(i))/radius_tumor)+45;

 V(j,i)=sum(Z)+steady_state(j,i);
 %sums up the homogeneous summation (left) and the steady state
 %response (right) and stores it into array
 end
end
temperature=V';
figure(1)
surf(tmesh(1:tskip:end),rmesh(1:rskip:end),temperature(1:rskip:end,1:tskip:end), 'EdgeColor', 'none') %transpose of each array
title('Analytical Solution')
xlabel('Time in seconds')
ylabel('Radius length, in meters')
zlabel('Temperature, in degrees Celsius') %throughout the homogeneous cell suspension
%--------------------------------------------------------------------------
%Plots temperature throughout the radius of the tumor at specific times listed below (2D)
temperature_twentyfive_seconds=temperature(:,251); %because t_total=100 seconds and step size for is 0.1,
%so 250 steps to reach 25 seconds, but add 1 to it because it starts at t=0.
%the analysis is done in the columns because the mesh is (t,x)
temperature_fifty_seconds=temperature(:,501); %because t_total=100 seconds and step size for is 0.1,
%so 500 steps to reach 50 seconds, but add 1 to it because it starts at t=0.
%the analysis is done in the columns because the mesh is (t,x)
temperature_hundred_seconds=temperature(:,1000);
figure(2)
plot(rmesh, temperature_twentyfive_seconds, 'ro-', rmesh,
temperature_fifty_seconds, 'g*-',rmesh,temperature_hundred_seconds,'m+-');
title('Temperature in Degrees Celsius of the Tumor');
xlabel('Radius, length in meters')
ylabel('Temperature, in degrees Celsius')
legend('At time=25 seconds', 'At time=50 seconds','At time=100 seconds');
%--------------------------------------------------------------------------