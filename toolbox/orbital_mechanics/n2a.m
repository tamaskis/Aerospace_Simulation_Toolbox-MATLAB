%==========================================================================
%
% n2a  Semi-major axis from mean motion.
%
%   a = n2a(n,mu)
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
%   n       - (1×1 double) mean motion [rad/s]
%   mu      - (1×1 double) standard gravitational parameter [m³/s²]
%
% -------
% OUTPUT:
% -------
%   a       - (1×1 double) semi-major axis [m]
%
% -----
% NOTE:
% -----
%   • This function is only valid for circular (e = 0) and elliptical
%     (0 < e < 1) orbits.
%
%==========================================================================
function a = n2a(n,mu)
    a = (mu/n^2)^(1/3);
end