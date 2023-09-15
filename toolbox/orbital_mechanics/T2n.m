%==========================================================================
%
% T2n  Mean motion from orbital period.
%
%   n = T2n(T)
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
%   T       - (1×1 double) orbital period [s]
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
function n = T2n(T)
    n = (2*pi)/T;
end