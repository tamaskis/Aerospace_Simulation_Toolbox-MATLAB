%==========================================================================
%
% moon_position  Moon position resolved in the ECI frame.
%
%   r_moon_eci = moon_position(MJD_UT1,epsilon)
%
% Author: Tamas Kis
% Last Update: 2022-02-01
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Algorithm 31 (p. 288)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UT1     - (1×1 double) UT1 (Universal Time 1) [MJD]
%   epsilon     - (1×1 double) obliquity of the ecliptic [rad]
%
% -------
% OUTPUT:
% -------
%   r_moon_eci  - (3×1 double) Moon position resolved in ECI frame [m]
%
%==========================================================================
function r_moon_eci = moon_position(MJD_UT1,epsilon)
    
    %  Earth mean equatorial radius [m]
    R_earth = R_EARTH;

    % Julian centuries since J2000.0 of UT1 [c]
    T_UT1 = mjd2t(MJD_UT1);
    
    % ecliptic longitude of the Moon [deg]
    lambda_moon = 218.32+481267.8813*T_UT1+6.29*sind(134.9+477198.85*...
        T_UT1)-1.27*sind(259.2-413335.38*T_UT1)+0.66*sind(235.7+...
        890534.23*T_UT1)+0.21*sind(269.9+954397.70*T_UT1)-0.19*...
        sind(357.5+35999.05*T_UT1)-0.11*sind(186.6+966404.05*T_UT1);
    lambda_moon = mod(lambda_moon,360);
    
    % ecliptic latitude of the Moon [deg]
    phi_moon = 5.13*sind(93.3+483202.03*T_UT1)+0.28*sind(228.2+...
        960400.87*T_UT1)-0.28*sind(318.3+6003.18*T_UT1)-0.17*sind(217.6-...
        407332.20*T_UT1);
    phi_moon = mod(phi_moon,360);
    
    % horizontal parallax [deg]
    P = 0.9508+0.0518*cosd(134.9+477198.85*T_UT1)+...
        0.0095*cosd(259.2-413335.38*T_UT1)+0.0078*cosd(235.7+890534.23*...
        T_UT1)+0.0028*cosd(269.9+954397.70*T_UT1);
    
    % distance from Earth to Moon [m]
    r_moon_mag = R_earth/sind(P);
    
    % convert obliquity of the ecliptic to degrees
    epsilon = rad2deg(epsilon);
    
    % Moon position resolved in ECI frame [m]
    r_moon_eci = r_moon_mag*[cosd(phi_moon)*cosd(lambda_moon);
                             cosd(epsilon)*cosd(phi_moon)*...
                                sind(lambda_moon)-...
                                sind(epsilon)*sind(phi_moon);
                             sind(epsilon)*cosd(phi_moon)*...
                                sind(lambda_moon)+cosd(epsilon)*...
                                sind(phi_moon)];
    
end