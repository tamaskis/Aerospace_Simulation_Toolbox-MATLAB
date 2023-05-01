%==========================================================================
%
% quat2eul_321  Quaternion to 3-2-1 Euler angles (yaw, pitch, and roll).
%
%   [psi,theta,phi] = quat2eul_321(q)
%
% See also axangle2eul_321, axang2mat, axang2quat, eul2axang_321,
% eul2mat_321, eul2quat_321, mat2axang, mat2eul_321, mat2quat, quat2axang,
% quat2mat.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-30
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
%   psi     - (1×1 double) yaw angle (1st rotation, about 3rd axis) [rad]
%   theta   - (1×1 double) pitch angle (2nd rotation, about 2nd axis) [rad]
%   phi     - (1×1 double) roll angle (3rd rotation, about 1st axis) [rad]
%
%==========================================================================
function [psi,theta,phi] = quat2eul_321(q)
    
    % normalizes quaternion
    q = quatnorm(q);
    
    % unpacks unit quaternion
    q0 = q(1);
    q1 = q(2);
    q2 = q(3);
    q3 = q(4);
    
    % R₁₃ element of the rotation matrix
    R13 = 2*(q1*q3-q0*q2);
    
    % determines if we are in a singular case, and if so, which one
    pitch_up = (R13 <= -1);
    pitch_down = (R13 >= 1);
    singular = (pitch_up || pitch_down);
    
    % yaw angle [rad]
    if singular
        psi = 0;
    else
        psi = iatan2(2*(q1*q2+q0*q3),1-2*(q2^2+q3^2));
    end
    
    % pitch angle [rad]
    if singular
        theta = -(pi/2)*sign(R13);
    else
        theta = -asin(R13);
    end
    
    % roll angle [rad]
    if pitch_up
        phi = iatan2(2*(q1*q2-q0*q3),2*(q1*q3+q0*q2));
    elseif pitch_down
        phi = -iatan2(2*(q2*q3-q0*q1),1-2*q1^2+q3^2);
    else
        phi = iatan2(2*(q2*q3+q0*q1),1-2*(q1^2+q2^2));
    end
    
end