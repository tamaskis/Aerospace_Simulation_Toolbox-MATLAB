%==========================================================================
%
% deg2dms  Degrees to degree-minute-second.
%
%   [d,m,s] = deg2dms(theta_deg)
%
% See also arcsec2deg, arcsec2rad, deg2arcsec, deg2rad, dms2deg, dms2rad,
% rad2arcsec, rad2deg, rad2dms.
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
%   theta_deg   - (1×1 double) angle in degrees [°]
%
% -------
% OUTPUT:
% -------
%   d           - (1×1 double) degrees [°]
%   m           - (1×1 double) arcminutes [']
%   s           - (1×1 double) arcseconds ["]
%
%==========================================================================
function [d,m,s] = deg2dms(theta_deg)
    
    % degree portion [°]
    d = fix(theta_deg);
    
    % auxiliary parameter [°]
    alpha = theta_deg-d;
    
    % arcminute portion [']
    m = fix(60*alpha);
    
    % arcsecond portion ["]
    s = 3600*(alpha-(m/60));
    
end