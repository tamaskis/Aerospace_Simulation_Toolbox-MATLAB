%==========================================================================
%
% quatinv  Inverse of a quaternion.
%
%   q_inv = quatinv(q)
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
%   q_inv   - (4×1 double) quaternion inverse
%
%==========================================================================
function q_inv = quatinv(q)
    
    % quaternion conjugate
    q_conj = quatconj(q);
    
    % quaternion inverse
    q_inv = quatnormalize(q_conj);
    
end