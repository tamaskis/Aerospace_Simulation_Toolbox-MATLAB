%==========================================================================
%
% eul2axang_321  3-2-1 Euler angles (yaw, pitch, and roll) to axis-angle 
% representation (passive rotation).
%
%   [e,Phi] = eul2axang_321(psi,theta,phi)
%
% See also axangle2eul_321, axang2mat, axang2quat, eul2mat_321,
% eul2quat_321, mat2axang, mat2eul_321, mat2quat, quat2axang, quat2eul_321,
% quat2mat.
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
%   psi     - (1×1 double) yaw angle (1st rotation, about 3rd axis) [rad]
%   theta   - (1×1 double) pitch angle (2nd rotation, about 2nd axis) [rad]
%   phi     - (1×1 double) roll angle (3rd rotation, about 1st axis) [rad]
%
% -------
% OUTPUT:
% -------
%   e       - (3×1 double) principal rotation vector
%   Phi     - (1×1 double) principal angle [rad]
%
% -----
% NOTE:
% -----
%   • ||e|| = 1
%   • Φ ∈ [0,π]
%   • If Φ = 0, then e is returned as (1,0,0)ᵀ.
%
%==========================================================================
function [e,Phi] = eul2axang_321(psi,theta,phi)
    
    % unit quaternion
    q = eul2quat_321(psi,theta,phi);
    
    % principal rotation vector and principal angle [rad]
    [e,Phi] = quat2axang(q);
    
end