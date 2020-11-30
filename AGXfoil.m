clear all
close all
clc

%% condições do problema
% Agua---------------------------------------------------------------
% P_atm = 1e5; %N/m^2
% V_0 = 100; %m/s %velocidade do fluido
% %Propriedades do fluido
% V_som = 1531; %m/s
% rho = 1000; %kg/m^3
% mu = 0.0891; %Pa*s
% Ar-------------------------------------------------------------------
P_atm = 0; %N/m^2
V_0 = 100; %m/s %velocidade do fluido
%Propriedades do fluido
V_som = 340; %m/s
rho = 1.2754; %kg/m^3
mu = 17.2e-6; %Pa*s
%--------------------------------------------------------------------
Re = rho*V_0*1/mu;
M = V_0/V_som;
% Re = 3e6;
% M=0.0;
alfa = 0;
NumNos = 50;

%% Inicializacao da populacao

