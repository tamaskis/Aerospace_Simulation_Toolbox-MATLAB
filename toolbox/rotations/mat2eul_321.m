%==========================================================================
%
% mat2eul_321  Rotation matrix to 3-2-1 Euler angles (yaw, pitch, and
% roll).
%
%   [psi,theta,phi] = mat2eul_321(R)
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
%   psi     - (1×1 double) yaw angle (1st rotation, about 3rd axis) [rad]
%   theta   - (1×1 double) pitch angle (2nd rotation, about 2nd axis) [rad]
%   phi     - (1×1 double) roll angle (3rd rotation, about 1st axis) [rad]
%
%==========================================================================
function [psi,theta,phi] = mat2eul_321(R)
    
    % determines if we are in a singular case, and if so, which one
    pitch_up = (R(1,3) <= -1);
    pitch_down = (R(1,3) >= 1);
    singular = (pitch_up || pitch_down);
    
    % yaw angle [rad]
    if singular
        psi = 0;
    else
        psi = iatan2(R(1,2),R(1,1));
    end
    
    % pitch angle [rad]
    if singular
        theta = -(pi/2)*sign(R(1,3));
    else
        theta = -asin(R(1,3));
    end
    
    % roll angle [rad]
    if pitch_up
        phi = iatan2(R(2,1),R(3,1));
    elseif pitch_down
        phi = iatan2(R(3,2),R(2,2));
    else
        phi = iatan2(R(2,3),R(3,3));
    end
    
end