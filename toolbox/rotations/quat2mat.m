%==========================================================================
%
% quat2mat  Quaternion to rotation matrix (passive rotation).
%
%   R = quat2mat(q)
%
% See also axangle2eul_321, axang2mat, axang2quat, eul2axang_321,
% eul2mat_321, eul2quat_321, mat2axang, mat2eul_321, mat2quat, quat2axang,
% quat2eul_321.
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
%   R       - (3×3 double) rotation matrix
%
% -----
% NOTE:
% -----
%   • This function assumes the scalar-first convention for quaternions.
%   • This function normalizes the input quaternion.
%
%==========================================================================
function R = quat2mat(q)
    
    % normalizes quaternion
    q = quatnormalize(q);
    
    % unpacks unit quaternion
    q0 = q(1);
    q1 = q(2);
    q2 = q(3);
    q3 = q(4);
    
    % rotation matrix
    R = [1-2*(q2^2+q3^2)   2*(q1*q2+q0*q3)   2*(q1*q3-q0*q2);
         2*(q1*q2-q0*q3)   1-2*(q1^2+q3^2)   2*(q2*q3+q0*q1);
         2*(q1*q3+q0*q2)   2*(q2*q3-q0*q1)   1-2*(q1^2+q2^2)];
    
end