%==========================================================================
%
% n2T  Orbital period from mean motion.
%
%   T = n2T(n)
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
%
% -------
% OUTPUT:
% -------
%   T       - (1×1 double) orbital period [s]
%
% -----
% NOTE:
% -----
%   • This function is only valid for circular (e = 0) and elliptical
%     (0 < e < 1) orbits.
%
%==========================================================================
function T = n2T(n)
    T = (2*pi)/n;
end