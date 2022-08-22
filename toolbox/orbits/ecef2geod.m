%==========================================================================
%
% ecef2geod  Geodetic coordinates from ECEF position.
%
%   [lat,lon,h] = ecef2geod(r_ecef)
%
% See also geod2ecef.
%
% Author: Tamas Kis
% Last Update: 2022-03-09
%
% REFERENCES:
%   [1] D'Amico, "Plotting of Orbits and Ground Tracks", AA 279A Lecture 
%       7-8 Slides (p. 7)
%   [2] Montenbruck and Gill, "Satellite Orbits", 4th Ed. (p. 188)
%   [3] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 138, 172)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef  - (3×1 double) position resolved in ECEF frame [m]
%
% -------
% OUTPUT:
% -------
%   lat     - (1×1 double) geodetic latitude [°]
%   lon     - (1×1 double) geodetic longitude [°]
%   h       - (1×1 double) geodetic altitude [m]
%
%==========================================================================
function [lat,lon,h] = ecef2geod(r_ecef)
        
    % Earth parameters
    R = R_EARTH;    % mean equatorial radius [m]
    e = E_EARTH;    % eccentricity [-]
    
    % extracts X, Y, and Z components of ECEF position vector [m]
    rX = r_ecef(1);
    rY = r_ecef(2);
    rZ = r_ecef(3);
    
    % magnitude of position vector [m]
    r = inorm(r_ecef);
    
    % scalar projection of position vector onto equatorial plane [m]
    rXY = sqrt(rX^2+rY^2);
    
    % geodetic longitude [°]
    lon = iatan2d(rY,rX);
    
    % initial guess for geodetic latitude [°]
    lat_old = asind(rZ/r);
    
    % tolerance and maximum number of iterations
    TOL = 1e-12;
    imax = 200;

    % initializes the error so the loop will be entered
    err = 2*TOL;
    
    % fixed-point iteration to solve for geodetic latitude
    i = 1;
    while (err > TOL) && (i < imax)

        % radius of curvature in the meridian [m]
        N_phi = R/sqrt(1-e^2*sind(lat_old)^2);
        
        % updates estimate of geodetic latitude [°]
        lat_new = iatan2d(rZ+N_phi*e^2*sind(lat_old),rXY);

        % calculates error
        err = abs(lat_new-lat_old);

        % stores updated estimate of geodetic latitude for next iteration
        lat_old = lat_new;
        
        % increments loop index
        i = i+1;

    end

    % geodetic latitude [°]
    lat = lat_new;
    
    % geodetic altitude [m]
    if (iabs(lat) >= 89) && (iabs(lat) <= 90)
        h = (rZ/sind(lat))-N_phi*(1-e^2);
    else
        h = (rXY/cosd(lat))-N_phi;
    end
      
end