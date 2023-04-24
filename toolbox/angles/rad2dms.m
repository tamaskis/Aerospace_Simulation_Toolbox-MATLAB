%==========================================================================
%
% rad2dms  Radians to degree-minute-second.
%
%   [d,m,s] = rad2dms(theta_rad)
%
% See also arcsec2deg, arcsec2rad, deg2arcsec, deg2dms, deg2rad, dms2deg,
% dms2rad, rad2arcsec, rad2deg.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-04
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/Aerospace_Simulation.pdf
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
%   d           - (1×1 double) degrees [°]
%   m           - (1×1 double) arcminutes [']
%   s           - (1×1 double) arcseconds ["]
%
%==========================================================================
function [d,m,s] = rad2dms(theta_rad)
    
    % angle in degrees [°]
    theta_deg = rad2deg(theta_rad);
    
    % angle in DMS form [°,',"]
    [d,m,s] = deg2dms(theta_deg);
    
end