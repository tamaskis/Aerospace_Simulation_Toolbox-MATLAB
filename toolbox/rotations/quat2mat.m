%==========================================================================
%
% quat2mat  Unit quaternion to rotation matrix.
%
%   R = quat2mat(q)
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
%   R       - (3×3 double) rotation matrix
%
%==========================================================================
function R = quat2mat(q)
    
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