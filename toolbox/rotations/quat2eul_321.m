%==========================================================================
%
% quat2eul_321  Unit quaternion to 3-2-1 Euler angles (yaw, pitch, and 
% roll).
%
%   [psi,theta,phi] = quat2eul_321(q)
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
%   psi     - (1×1 double) yaw angle (1st rotation, about 3rd axis) [rad]
%   theta   - (1×1 double) pitch angle (2nd rotation, about 2nd axis) [rad]
%   phi     - (1×1 double) roll angle (3rd rotation, about 1st axis) [rad]
%
%==========================================================================
function [psi,theta,phi] = quat2eul_321(q)
    
    % rotation matrix from unit quaternion
    R = quat2mat(q);
    
    % yaw, pitch, and roll angles from rotation matrix [rad]
    [psi,theta,phi] = mat2eul_321(R);
    
end