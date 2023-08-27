%==========================================================================
%
% eul2quat_321  3-2-1 Euler angles (yaw, pitch, and roll) to unit
% quaternion (passive rotation).
%
%   q = eul2quat_321(psi,theta,phi)
%
% See also axangle2eul_321, axang2mat, axang2quat, eul2axang_321,
% eul2mat_321, mat2axang, mat2eul_321, mat2quat, quat2axang, quat2eul_321,
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
%   q       - (4×1 double) unit quaternion
%
% -----
% NOTE:
% -----
%   • This function assumes the scalar-first convention for quaternions.
%   • The scalar part, q₀, is chosen to be positive.
%   • q is normalized.
%
%==========================================================================
function q = eul2quat_321(psi,theta,phi)
    
    % precomputes trigonometric functions
    c1 = cos(phi/2);
    s1 = sin(phi/2);
    c2 = cos(theta/2);
    s2 = sin(theta/2);
    c3 = cos(psi/2);
    s3 = sin(psi/2);
    
    % computes quaternion
    q = [c1*c2*c3+s1*s2*s3;
         s1*c2*c3-c1*s2*s3;
         c1*s2*c3+s1*c2*s3;
         c1*c2*s3-s1*s2*c3];
    
    % ensures scalar part of quaternion is positive
    if q(1) < 0
        q = -q;
    end
    
    % normalizes quaternion
    q = quatnormalize(q);
    
end