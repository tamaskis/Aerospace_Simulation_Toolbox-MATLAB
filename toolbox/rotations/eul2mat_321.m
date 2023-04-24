%==========================================================================
%
% eul2mat_321  3-2-1 Euler angles (yaw, pitch, and roll) to rotation
% matrix.
%
%   R = eul2mat_321(psi,theta,phi)
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
%   psi     - (1×1 double) yaw angle (1st rotation, about 3rd axis) [rad]
%   theta   - (1×1 double) pitch angle (2nd rotation, about 2nd axis) [rad]
%   phi     - (1×1 double) roll angle (3rd rotation, about 1st axis) [rad]
%
% -------
% OUTPUT:
% -------
%   R       - (3×3 double) rotation matrix
%
%==========================================================================
function R = eul2mat_321(psi,theta,phi)
    R = rot321(psi,theta,phi);
end