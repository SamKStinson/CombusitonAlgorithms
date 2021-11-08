clc; clear;
%Current example solves for molar concentrations, T, and P for combustion
%reaction in a well-stirred reactor with simplifications applied

%Inital P,T
Ru=8.315;
P0=40.25*101.325;
T0 = 862;

%Inital concentrations
F0=(1-(16/17))*(P0/(Ru*T0));
O0=(16/17)*(P0/(Ru*T0));


y0 = [F0,O0,0, T0, P0];
%y0=[1/17 16/17 0 753 2545];
tspan =linspace(0,.005,100000);
[t,y] = ode45(@odefun,tspan,y0);
[F]=y(:,1);
[Ox]=y(:,2);
[Pr]=y(:,3);
T=y(:,4);
P=y(:,5);

figure(1)
plot(t,F,t,Ox,t,Pr)
xlim([.00025,0.000265])
ylim([0,.6])
xlabel('Time [s]')
ylabel('Species Concentrations [kmol/kg]')
legend('Fuel','Oxygen','Products')
title('Molar Concentrations vs Time')

figure(2)
plot(t,T)
xlim([.000,0.0005])
xlabel('Time [s]')
ylabel('Temperature [K]')
title('Temp vs Time')

%xlim([0.0034,0.0044])
%ylim([0,.45])

figure(3)
plot(t,P)
xlim([.000,0.0005])
xlabel('Time [s]')
ylabel('Pressure [kPa]')
title ('Pressure vs Time')

function dydt = odefun(t,y)
%molecualr weight for all species (kg/kmol)
mw=29;

%specific enthalpies of fuel (kJ/kg)
hf=4e4;
hbar= hf*mw;

%specific heats for all species (kJ/kmol*K)
cp=1.200;
cpbar= mw*cp;

%Universal gas constant
Ru=8.315;

%Inital Conditions
P0 = 40.23 * 101.325;
T0 = 862;


dydt = zeros(5,1);

%Enter your system of ODE's equations in the same form

dydt(1) = (-6.19e9) * exp(-15098 / y(4)) * (y(1)^0.1) * ((.21*y(2))^1.65);
dydt(2) = 16 * (dydt(1));
dydt(3) = -17 * (dydt(1));
dydt(4) = ((-dydt(1))*hbar)/((cpbar-Ru)*(y(5)/(Ru*y(4))));
dydt(5) = (P0/T0)*dydt(4);
end
