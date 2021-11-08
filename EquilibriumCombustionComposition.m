%C12H26
x=12;
y=26;
phi = 1.1;
mwF = 170.337;

%mols of air
Na = ((x+y/4)/phi);

%Fuel's enthalpy values (kJ/kg)
hfF = -292162;
hfgF = 256;

%Reactants - 1st eq

Hr = 1*(hfF-hfgF*mwF) + Na*(19250) + Na *3.76*(18222);


cp_xco2 = 56.205;
cp_xco = 34.148;
cp_xh2o = 43.874;
cp_xh2 = 31.077;
cp_xn2 = 33.707;

%Total mols in product stream
Ntot = x + (y/2) + Na*3.76;

%Equilibrium constant for water-gas shift
Kp = 0.1635;

syms Xco2 Xco Xh2o Xh2 T

eqn1 = T*((4960*Xco2)+(3013*Xco)+(3871*Xh2o)+(2742*Xh2))+(2091.35*T)-(36204439*Xco2)-(10652077*Xco)-(2249092*Xh2o)-(817186*Xh2)-(623221.35)==Hr;
eqn2 = (Xh2*Xco2)/(Xco*Xh2o)==Kp;
eqn3 = Xco + Xco2 == .1360;
eqn4 = 2*Xh2o + 2*Xh2 == .2947;
eqn5 = 2*Xco2 + Xco + Xh2o == .3812;

%solutions
sol = vpasolve([eqn1,eqn2,eqn3,eqn4,eqn5],[Xco2 Xco Xh2o Xh2 T]);
Xco2sol = (sol.Xco2);
Xcosol = (sol.Xco);
Xh2osol = (sol.Xh2o);
Xh2sol = (sol.Xh2);
Tsol = (sol.T);

N_check = Xco2sol(1)+Xcosol(1)+Xh2osol(1)+Xh2sol(1)+(Na*3.76/Ntot)

solution = ["Xco2" Xco2sol(1);"Xco" Xcosol(1);"Xh2o" Xh2osol(1);"Xh2" Xh2sol(1);"Tad" Tsol(1)+Tsol(2)]

