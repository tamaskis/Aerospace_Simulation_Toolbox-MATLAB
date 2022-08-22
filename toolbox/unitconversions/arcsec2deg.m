%==========================================================================
%
% arcsec2deg  Arcseconds to degrees.
%
%   theta_deg = arcsec2deg(theta_arcsec)
%
% See also deg2rad, deg2arcsec, rad2deg, rad2arcsec, arcsec2rad.
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
%   theta_deg       - (1×1 double) angle in degrees [°]
%
%==========================================================================
function theta_deg = arcsec2deg(theta_arcsec)
    theta_deg = (1/3600)*theta_arcsec;
end