%==========================================================================
%
% quat2axang  Quaternion to axis-angle representation.
%
%   [e,Phi] = quat2axang(q)
%
% See also axangle2eul_321, axang2mat, axang2quat, eul2axang_321,
% eul2mat_321, eul2quat_321, mat2axang, mat2eul_321, mat2quat, 
% quat2eul_321, quat2mat.
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
%   e       - (3×1 double) principal rotation vector
%   Phi     - (1×1 double) principal angle [rad]
%
%==========================================================================
function [e,Phi] = quat2axang(q)
    
    % ensures the scalar component of the quaternion is positive
    if q(1) < 0
        q = -q;
    end
    
    % normalizes quaternion
    q = quatnorm(q);
    
    % unpacks unit quaternion
    q0 = q(1);
    q1 = q(2);
    q2 = q(3);
    q3 = q(4);
    
    % principal rotation vector
    if abs(q0) < 1
        e = [q1;q2;q3];
    else
        e = [1;0;0];
    end
    
    % normalizes principal rotation vector
    e = e/inorm(e);
    
    % principal angle [rad]
    Phi = 2*acos(q0);
    
end