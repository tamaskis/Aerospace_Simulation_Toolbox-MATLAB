%==========================================================================
%
% sun_position  Sun position resolved in the ECI frame.
%
%   r_sun_eci = sun_position(MJD_UT1,epsilon)
%
% Author: Tamas Kis
% Last Update: 2022-02-20
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Algorithm 29 (pp. 279-280)
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
%   r_sun_eci   - (3×1 double) Sun position resolved in ECI frame [m]
%
%==========================================================================
function r_sun_eci = sun_position(MJD_UT1,epsilon)

    % Julian centuries since J2000.0 of UT1 [c]
    T_UT1 = mjd2t(MJD_UT1);
    
    % mean ecliptic longitude and mean anomaly of Sun (in ECI frame) [deg]
    lambda_M_sun = mod(280.460+36000.771*T_UT1,360);
    M = mod(357.5291092+35999.05034*T_UT1,360);
    
    % ecliptic longitude [deg]
    lambda_sun = mod(lambda_M_sun+1.914666471*sind(M)+0.019994643*...
        sind(2*M),360);
    
    % distance from Earth to Sun [AU]
    r_sun_mag = 1.000140612-0.016708617*cosd(M)-0.000139589*cosd(2*M);
    
    % converts distance to m
    r_sun_mag = 149597870000*r_sun_mag;

    % converts obliquity to degrees
    epsilon = rad2deg(epsilon);
    
    % Sun position vector resolved in ECI frame [m]
    r_sun_eci = r_sun_mag*[cosd(lambda_sun);
                           cosd(epsilon)*sind(lambda_sun);
                           sind(epsilon)*sind(lambda_sun)];
    
end