%==========================================================================
%
% mat2quat  Rotation matrix to unit quaternion (passive rotation).
%
%   q = mat2quat(R)
%
% See also axangle2eul_321, axang2mat, axang2quat, eul2axang_321,
% eul2mat_321, eul2quat_321, mat2axang, mat2eul_321, quat2axang,
% quat2eul_321, quat2mat.
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
%   R       - (3×3 double) rotation matrix
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
function q = mat2quat(R)
    
    % computes quaternion elements
    q0 = sqrt((R(1,1)+R(2,2)+R(3,3)+1)^2+(R(3,2)-R(2,3))^2+(R(1,3)-...
        R(3,1))^2+(R(2,1)-R(1,2))^2);
    q1 = sign((R(2,3)-R(3,2)))*sqrt((R(3,2)-R(2,3))^2+(R(1,1)-R(2,2)-...
        R(3,3)+1)^2+(R(2,1)+R(1,2))^2+(R(3,1)+R(1,3))^2);
    q2 = sign((R(3,1)-R(1,3)))*sqrt((R(1,3)-R(3,1))^2+(R(2,1)+R(1,2))^2+...
        (R(2,2)-R(1,1)-R(3,3)+1)^2+(R(3,2)+R(2,3))^2);
    q3 = sign((R(1,2)-R(2,1)))*sqrt((R(2,1)-R(1,2))^2+(R(3,1)+R(1,3))^2+...
        (R(3,2)+R(2,3))^2+(R(3,3)-R(1,1)-R(2,2)+1)^2);
    
    % assembles quaternion
    q = [q0;
         q1;
         q2;
         q3];
    
    % normalizes quaternion
    q = quatnormalize(q);
    
end