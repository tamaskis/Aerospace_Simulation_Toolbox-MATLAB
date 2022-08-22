%==========================================================================
%
% geod2ecef  ECEF position from geodetic coordinates.
%
%   r_ecef = geod2ecef(lat,lon,h)
%
% See also ecef2geod.
%
% Author: Tamas Kis
% Last Update: 2022-02-16
%
% REFERENCES:
%   [1] D'Amico, "Plotting of Orbits and Ground Tracks", AA 279A Lecture 
%       7-8 Slides (p. 6)
%   [2] Montenbruck and Gill, "Satellite Orbits", 4th Ed. (p. 188)
%   [3] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 138, 144)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   lat     - (1×1 double) geodetic latitude [deg]
%   lon    	- (1×1 double) geodetic longitude [deg]
%   h      	- (1×1 double) geodetic altitude [m]
%
% -------
% OUTPUT:
% -------
%   r_ecef  - (3×1 double) position resolved in ECEF frame [m]
%
%==========================================================================
function r_ecef = geod2ecef(lat,lon,h)
    
    % Earth parameters
    R = R_EARTH;    % mean equatorial radius [m]
    e = E_EARTH;    % eccentricity [-]
    
    % radius of curvature in the meridian [m]
    N_phi = R/sqrt(1-e^2*sind(lat)^2);
    
    % position resolved in ECEF frame [m]
    r_ecef = [(N_phi+h)*cosd(lat)*cosd(lon);
              (N_phi+h)*cosd(lat)*sind(lon);
              (N_phi*(1-e^2)+h)*sind(lat)];
      
end