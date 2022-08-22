%==========================================================================
%
% arcsec2rad  Arcseconds to radians.
%
%   theta_rad = arcsec2rad(theta_arcsec)
%
% See also deg2rad, deg2arcsec, rad2deg, rad2arcsec, arcsec2deg.
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
%   theta_arcsec    - (1×1 double) angle in arcseconds ['']
%
% -------
% OUTPUT:
% -------
%   theta_rad       - (1×1 double) angle in radians [rad]
%
%==========================================================================
function theta_rad = arcsec2rad(theta_arcsec)
    theta_rad = (pi/648000)*theta_arcsec;
end