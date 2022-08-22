%==========================================================================
%
% h_approx  Approximate geodetic altitude from ECEF position.
%
%   h = h_approx(r_ecef)
%
% Author: Tamas Kis
% Last Update: 2022-02-16
%
% REFERENCES:
%   [1] Long et al., "Goddard Trajectory Determination System (GTDS)
%       Mathematical Theory: Revision 1" (pp. 4-59 to 4-60)
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
%   h       - (1×1 double) approximate geodetic altitude [m]
%
%==========================================================================
function h = h_approx(r_ecef)

    % Earth parameters
    R = R_EARTH;    % mean equatorial radius [m]
    e = E_EARTH;    % eccentricity [-]
    f = F_EARTH;    % flattening [-]
    
    % polar radius of the Earth [m]
    R_pole = R*(1-f);

    % extract X and Y ECEF position components [m]
    rX = r_ecef(1);
    rY = r_ecef(2);

    % scalar projection of position vector onto equatorial plane [m]
    rXY = sqrt(rX^2+rY^2);
    
    % magnitude of ECEF position vector [m]
    r = inorm(r_ecef);
    
    % approximate geodetic altitude [m]
    h = r-R_pole/sqrt(1-e^2*(rXY/r)^2);
      
end