%==========================================================================
%
% quatinv  Inverse of a quaternion.
%
%   q_inv = quatinv(q)
%
% See also quatchain, quatconj, quatmul, quatnorm, quatnormalize,
% quatrotate.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-05-07
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
% -----
% NOTE:
% -----
%   • This function assumes the scalar-first convention for quaternions.
%   • q does not have to be input as a unit quaternion (this function is
%     for all quaternions, not just unit quaternions).
%   • q⁻¹ is not normalized.
%
%==========================================================================
function q_inv = quatinv(q)
    q_inv = quatconj(q)/(q.'*q);
end