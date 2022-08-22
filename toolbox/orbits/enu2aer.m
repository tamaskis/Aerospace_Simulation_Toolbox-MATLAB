%==========================================================================
%
% enu2aer  Range, azimuth, elevation, and their rates from ENU position and
% velocity.
%
%   [Az,El,rho] = enu2aer(rho_enu)
%   [Az,El,rho,Az_dot,El_dot,rho_dot] = enu2aer(rho_enu,rho_dot_enu)
%
% See also aer2enu.
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
%   rho_enu     - (3×1 double) ENU position resolved in ENU frame
%   rho_dot_enu - (3×1 double) (OPTIONAL) ENU velocity resolved in ENU 
%                 frame
%
% -------
% OUTPUT:
% -------
%   Az          - (1×1 double) azimuth [°]
%   El          - (1×1 double) elevation [°]
%   rho         - (1×1 double) range [same as rho_enu]
%   Az_dot      - (1×1 double) azimuth rate [°/s]
%   El_dot      - (1×1 double) elevation rate [°/s]
%   rho_dot     - (1×1 double) range rate [same as rho_dot_enu]
%
% -----
% NOTE:
% -----
%   --> "rho_enu" and "rho_dot_enu" can be input in any units, but they
%       MUST be consistent if both are input. The units of "rho" will match
%       those of "rho_enu", and the units of "rho_dot" will match those of 
%       "rho_dot_enu".
%   --> Az is measured clockwise from N towards E about the U axis.
%   --> El is measured from the EN plane towards the satellite's ENU 
%       position vector, rho_enu.
%   --> -90° ≤ El ≤ 90°
%   -->   0° ≤ Az < 360°
%
%==========================================================================
function [Az,El,rho,Az_dot,El_dot,rho_dot] = enu2aer(rho_enu,rho_dot_enu)
    
    % extracts east, north, and up components of ENU position
    rho_E = rho_enu(1);
    rho_N = rho_enu(2);
    rho_U = rho_enu(3);

    % azimuth [°]
    Az = iatan2d(rho_E,rho_N);

    % elevation [°]
    El = atand(rho_U/sqrt(rho_E^2+rho_N^2));

    % range
    rho = inorm(rho_enu);

    % rates only calculated if ENU velocity provided
    if (nargin == 2) && ~isempty(rho_dot_enu)

        % extracts east, north, and up components of ENU velocity
        rho_dot_E = rho_dot_enu(1);
        rho_dot_N = rho_dot_enu(2);
        rho_dot_U = rho_dot_enu(3);
        
        % range rate
        rho_dot = inorm(rho_dot_enu);

        % azimuth rate [°/s]
        Az_dot = ((rho_N*rho_dot_E-rho_E*rho_dot_N)/rho_N^2)*cosd(Az)^2;

        % elevation rate [°/s]
        El_dot = (rho_dot_U-rho_dot*sind(El))/(rho*cosd(El));

    end

end