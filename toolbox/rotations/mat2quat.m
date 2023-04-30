%==========================================================================
%
% mat2quat  Rotation matrix to unit quaternion.
%
%   q = mat2quat(R)
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
%   R       - (3×3 double) rotation matrix
%
% -------
% OUTPUT:
% -------
%   q       - (4×1 double) unit quaternion
%
%==========================================================================
function q = mat2quat(R)
    
%     % computes quaternion elements
%     q0 = sqrt((R(1,1)+R(2,2)+R(3,3)+1)^2+(R(3,2)-R(2,3))^2+(R(1,3)-...
%         R(3,1))^2+(R(2,1)-R(1,2))^2);
%     q1 = sign((R(3,2)-R(2,3)))*sqrt((R(3,2)-R(2,3))^2+(R(1,1)-R(2,2)-...
%         R(3,3)+1)^2+(R(2,1)+R(1,2))^2+(R(3,1)+R(1,3))^2);
%     q2 = sign((R(1,3)-R(3,1)))*sqrt((R(1,3)-R(3,1))^2+(R(2,1)+R(1,2))^2+...
%         (R(2,2)-R(1,1)-R(3,3)+1)^2+(R(3,2)+R(2,3))^2);
%     q3 = sign((R(2,1)-R(1,2)))*sqrt((R(2,1)-R(1,2))^2+(R(3,1)+R(1,3))^2+...
%         (R(3,2)+R(2,3))^2+(R(3,3)-R(1,1)-R(2,2)+1)^2);

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
    q = quatnorm(q);
    
end