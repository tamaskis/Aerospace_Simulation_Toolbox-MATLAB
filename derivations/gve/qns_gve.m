%% qns_gve.m
% Astrodynamics Toolbox
%
% Derivation of the Gauss variational equations for the quasi-nonsingular
% Keplerian orbital elements.
%
% Author: Tamas Kis
% Last Update: 2022-01-04



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;



%% CLASSICAL GVES

% initialize variables
syms a e i n nu r w positive;
syms fR fT fN;

% da/dt
dadt_R = (2*e*sin(nu))/(n*sqrt(1-e^2));
dadt_T = (2*a*sqrt(1-e^2))/(n*r);
dadt_N = 0;
dadt = (dadt_R*fR)+(dadt_T*fT)+(dadt_N*fN);

% de/dt
dedt_R = (sqrt(1-e^2)*sin(nu))/(n*a);
dedt_T = (sqrt(1-e^2)/(n*a^2*e))*((a^2*(1-e^2)/r)-r);
dedt_N = 0;
dedt = (dedt_R*fR)+(dedt_T*fT)+(dedt_N*fN);

% di/dt
didt_R = 0;
didt_T = 0;
didt_N = (r*cos(w+nu))/(n*a^2*sqrt(1-e^2));
didt = (didt_R*fR)+(didt_T*fT)+(didt_N*fN);

% dΩ/dt
dOdt_R = 0;
dOdt_T = 0;
dOdt_N = (r*sin(w+nu))/(n*a^2*sqrt(1-e^2)*sin(i));
dOdt = (dOdt_R*fR)+(dOdt_T*fT)+(dOdt_N*fN);

% dω/dt
dwdt_R = -((sqrt(1-e^2)*cos(nu))/(n*a*e));
dwdt_T = ((sqrt(1-e^2)*sin(nu))/(n*a*e))*((2+e*cos(nu))/(1+e*cos(nu)));
dwdt_N = -((r*cot(i)*sin(w+nu))/(n*a*e^2*sqrt(1-e^2)));
dwdt = (dwdt_R*fR)+(dwdt_T*fT)+(dwdt_N*fN);

% dM/dt
dMdt_R = -((1/(n*a))*((2*r)/a)-(((1-e^2)*cos(nu))/e));
dMdt_T = -((((1-e^2)*sin(nu))/(n*a*e))*(1+r/(a*(1-e^2))));
dMdt_N = 0;
dMdt = n+(dMdt_R*fR)+(dMdt_T*fT)+(dMdt_N*fN);



%% QUASI-NONSINGULAR GVES

% duM/dt
duMdt_R = simplify(dwdt_R+dMdt_R,'Steps',50)
duMdt_T = simplify(dwdt_T+dMdt_T,'Steps',50)
duMdt_N = simplify(dwdt_N+dMdt_N,'Steps',50)

% dex/dt
dexdt_R = simplify(dedt_R*cos(w)-e*dwdt_R*sin(w),'Steps',50)
dexdt_T = simplify(dedt_T*cos(w)-e*dwdt_T*sin(w),'Steps',50)
dexdt_N = simplify(dedt_N*cos(w)-e*dwdt_N*sin(w),'Steps',50)

% dey/dt
deydt_R = simplify(dedt_R*sin(w)+e*dwdt_R*cos(w),'Steps',50)
deydt_T = simplify(dedt_T*sin(w)+e*dwdt_T*cos(w),'Steps',50)
deydt_N = simplify(dedt_N*sin(w)+e*dwdt_N*cos(w),'Steps',50)