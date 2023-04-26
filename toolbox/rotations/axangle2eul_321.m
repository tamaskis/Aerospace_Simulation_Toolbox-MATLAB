%==========================================================================
%
% axangle2eul_321  Axis-angle representation to 3-2-1 Euler angles (yaw, 
% pitch, and roll).
%
%   [psi,theta,phi] = axangle2eul_321(e,Phi)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-25
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
%   e       - (3×1 double) principal rotation vector
%   Phi     - (1×1 double) principal angle [rad]
%
% -------
% OUTPUT:
% -------
%   psi     - (1×1 double) yaw angle (1st rotation, about 3rd axis) [rad]
%   theta   - (1×1 double) pitch angle (2nd rotation, about 2nd axis) [rad]
%   phi     - (1×1 double) roll angle (3rd rotation, about 1st axis) [rad]
%
%==========================================================================
function [psi,theta,phi] = axangle2eul_321(e,Phi)
    
    % precomputes trigonometric functions
    c = cos(Phi);
    s = sin(Phi);
    
    % yaw angle [rad]
    psi = iatan2(e(1)*e(2)*(1-c)+e(3)*s,e(1)^2*(1-c)+c);
    
    % pitch angle [rad]
    a = e(1)*e(3)*(1-c)-e(2)*s;
    if iabs(a) < 1
        theta = -asin(a);
    else
        theta = -pi*sign(a);
    end
    
    % roll angle [rad]
    phi = iatan2(e(2)*e(3)*(1-c)+e(1)*s,e(3)^2*(1-c)+c);
    
end