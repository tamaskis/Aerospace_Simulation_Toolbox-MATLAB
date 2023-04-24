%==========================================================================
%
% quatinv  Inverse of a unit quaternion.
%
%   q_inv = quatinv(q)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-23
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
%   q       - (4×1 double) unit quaternion
%
% -------
% OUTPUT:
% -------
%   q_inv   - (4×1 double) unit quaternion inverse
%
%==========================================================================
function q_inv = quatinv(q)
    q_inv = [ q(1);
             -q(2:4)];
end