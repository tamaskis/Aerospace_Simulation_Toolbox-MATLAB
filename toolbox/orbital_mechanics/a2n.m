%==========================================================================
%
% a2n  Mean motion from semi-major axis.
%
%   n = a2n(a,mu)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-09-14
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
%   a       - (1×1 double) semi-major axis [m]
%   mu      - (1×1 double) standard gravitational parameter [m³/s²]
%
% -------
% OUTPUT:
% -------
%   n       - (1×1 double) mean motion [rad/s]
%
% -----
% NOTE:
% -----
%   • This function is only valid for circular (e = 0) and elliptical
%     (0 < e < 1) orbits.
%
%==========================================================================
function n = a2n(a,mu)
    n = sqrt(mu/a^3);
end