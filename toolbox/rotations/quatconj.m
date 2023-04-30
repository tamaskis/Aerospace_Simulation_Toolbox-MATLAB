%==========================================================================
%
% quatconj  Conjugate of a quaternion.
%
%   q_conj = quatconj(q)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-29
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
%   q       - (4×1 double) quaternion
%
% -------
% OUTPUT:
% -------
%   q_conj  - (4×1 double) quaternion conjugate
%
%==========================================================================
function q_conj = quatconj(q)
    q_conj = [ q(1);
              -q(2:4)];
end