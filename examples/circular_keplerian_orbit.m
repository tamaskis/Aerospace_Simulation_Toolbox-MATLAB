%% circular_keplerian_orbit.m
% Astrodynamics Toolbox
%
% Circular Keplerian orbit simulation.
%
% Author: Tamas Kis
% Last Update: 2022-01-05



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" functions
addpath(genpath("../toolbox"));



%% SIMULATION

% epoch
UTC0_cal = [2017,01,01,0,0,0];  % UTC time at epoch [YYYY,MM,DD,hh,mm,ss]

% orbital elements at epoch
a = 6853137;    % semi-major axis [m]
e = 0;          % eccentricity [-]
i = 0.9006;     % inclination [rad]
Om = pi;        % right ascension of the ascending node [rad]
w = pi;         % argument of periapsis [rad]
nu0 = pi/4;     % true anomaly at epoch [rad]

% time for 3.5 orbits
t_length = 3.5*a2T(a);

% simulates one orbit
[t,nu,M,E,r_eci,v_eci,r_ecef,v_ecef,lat,lon,h,GMST] = kepler_propagator(...
    a,e,i,Om,w,nu0,UTC0_cal,t_length);

% stores orbit data in structure
orbit_data.t = t;
orbit_data.nu = nu;
orbit_data.M = M;
orbit_data.E = E;
orbit_data.r_eci = r_eci;
orbit_data.v_eci = v_eci;
orbit_data.r_ecef = r_ecef;
orbit_data.v_ecef = v_ecef;
orbit_data.lat = lat;
orbit_data.lon = lon;
orbit_data.h = h;
orbit_data.GMST = GMST;

% saves orbit data
save('sampledata/circular_keplerian_orbit.mat','orbit_data');