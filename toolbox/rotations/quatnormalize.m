%==========================================================================
%
% quatnormalize  Normalize a quaternion.
%
%   q = quatnormalize(q)
%
% See also quatchain, quatconj, quatinv, quatmul, quatnorm, quatrotate.
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
%   q       - (4×1 double) unit quaternion
%
%==========================================================================
function q = quatnormalize(q)
    q = q/quatnorm(q);
end