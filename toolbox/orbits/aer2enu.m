%==========================================================================
%
% aer2enu  ENU position and velocity from range, azimuth, elevation, and 
% their rates.
%
%   rho_enu = aer2enu(Az,El,rho)
%   [rho_enu,rho_dot_enu] = aer2enu(Az,El,rho,Az_dot,El_dot,rho_dot)
%
% See also enu2aer.
%
% Author: Tamas Kis
% Last Update: 2022-02-26
%
% REFERENCES:
%   [1] D'Amico, "Earth Ellipsoid, Geoid, Terrain, Relative Motion w.r.t. 
%       Ground Station", AA 279A Lecture 7-8 Slides (pp. 14-16)
%   [2] Montenbruck and Gill, "Satellite Orbits" (pp. 36-38)
%   [3] Tapley, et al., "Statistical Orbit Determination" (pp. 80-82)
%   [4] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (4-4) (p. 261)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   Az          - (1×1 double) azimuth [°]
%   El          - (1×1 double) elevation [°]
%   rho         - (1×1 double) range
%   Az_dot      - (1×1 double) (OPTIONAL) azimuth rate [°/s]
%   El_dot      - (1×1 double) (OPTIONAL) elevation rate [°/s]
%   rho_dot     - (1×1 double) (OPTIONAL) range rate
%
% -------
% OUTPUT:
% -------
%   rho_enu     - (3×1 double) ENU position resolved in ENU frame
%   rho_dot_enu - (3×1 double) ENU velocity resolved in ENU frame
%
% -----
% NOTE:
% -----
%   --> "rho" and "rho_dot" can be input in any units, but they MUST be
%       consistent if both are input. The units of "rho_enu" will match
%       those of "rho", and the units of "rho_dot_enu" will match those of 
%       "rho_dot".
%   --> Az is measured clockwise from N towards E about the U axis.
%   --> El is measured from the EN plane towards the satellite's ENU 
%       position vector, rho_enu.
%   --> -90° ≤ El ≤ 90°
%   -->   0° ≤ Az < 360°
%
%==========================================================================
function [rho_enu,rho_dot_enu] = aer2enu(Az,El,rho,Az_dot,El_dot,rho_dot)
    
    % precomputes trigonometric functions
    sAz = sind(Az);
    cAz = cosd(Az);
    sEl = sind(El);
    cEl = cosd(El);
    
    % position resolved in ENU frame
    rho_enu = rho*[cEl*sAz;
                   cEl*cAz;
                   sEl];
    
    % ENU velocity resolved in ENU frame
    rho_dot_enu = [rho_dot*cEl*sAz+rho*cAz*cEl*Az_dot-rho*sEl*sAz*El_dot;
                   rho_dot*cEl*cAz-rho*sAz*cEl*Az_dot-rho*sEl*cAz*El_dot;
                   rho_dot*sEl+rho*cEl*El_dot];
    
end