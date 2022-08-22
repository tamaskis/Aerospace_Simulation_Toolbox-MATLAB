%==========================================================================
%
% rad2deg  Radians to degrees.
%
%   theta_deg = rad2deg(theta_deg)
%
% See also deg2rad, deg2arcsec, rad2arcsec, arcsec2deg, arcsec2rad.
%
% Author: Tamas Kis
% Last Update: 2022-03-12
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   theta_rad   - (1×1 double) angle in radians [rad]
%
% -------
% OUTPUT:
% -------
%   theta_deg   - (1×1 double) angle in degrees [°]
%
%==========================================================================
function theta_deg = rad2deg(theta_rad)
    theta_deg = (180/pi)*theta_rad;
end