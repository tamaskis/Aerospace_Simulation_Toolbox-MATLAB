%==========================================================================
%
% rad2arcsec  Radians to arcseconds.
%
%   theta_sec = rad2arcsec(theta_rad)
%
% See also deg2rad, deg2arcsec, rad2deg, arcsec2deg, arcsec2rad.
%
% Author: Tamas Kis
% Last Update: 2022-03-12
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (p. 175)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   theta_rad       - (1×1 double) angle in radians [rad]
%
% -------
% OUTPUT:
% -------
%   theta_arcsec    - (1×1 double) angle in arcseconds ['']
%
%==========================================================================
function theta_arcsec = rad2arcsec(theta_rad)
    theta_arcsec = (648000/pi)*theta_rad;
end