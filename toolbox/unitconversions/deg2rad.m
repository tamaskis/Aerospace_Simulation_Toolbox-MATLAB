%==========================================================================
%
% deg2rad  Degrees to radians.
%
%   theta_rad = deg2rad(theta_deg)
%
% See also deg2arcsec, rad2deg, rad2arcsec, arcsec2deg, arcsec2rad.
%
% Author: Tamas Kis
% Last Update: 2022-03-12
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   theta_deg   - (1×1 double) angle in degrees [°]
%
% -------
% OUTPUT:
% -------
%   theta_rad   - (1×1 double) angle in radians [rad]
%
%==========================================================================
function theta_rad = deg2rad(theta_deg)
    theta_rad = (pi/180)*theta_deg;
end