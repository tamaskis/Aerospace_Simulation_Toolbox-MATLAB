%==========================================================================
%
% quatconj  Conjugate of a quaternion.
%
%   q_conj = quatconj(q)
%
% See also quatchain, quatinv, quatmul, quatnorm, quatnormalize,
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
%   q_conj  - (4×1 double) quaternion conjugate
%
% -----
% NOTE:
% -----
%   • This function assumes the scalar-first convention for quaternions.
%   • q does not have to be input as a unit quaternion (this function is
%     for all quaternions, not just unit quaternions).
%   • q_conj is not normalized.
%
%==========================================================================
function q_conj = quatconj(q)
    q_conj = [ q(1);
              -q(2:4)];
end