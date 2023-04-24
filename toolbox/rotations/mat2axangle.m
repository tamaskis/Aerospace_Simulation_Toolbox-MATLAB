%==========================================================================
%
% mat2axangle  Axis-angle representation to unit quaternion.
%
%   [e,Phi] = mat2axangle(R)
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
%   e       - (3×1 double) principal rotation vector
%   Phi     - (1×1 double) principal angle [rad]
%
% -----
% NOTE:
% -----
%   • Phi is returned as an angle between 0 and pi (inclusive).
%   • e is return as a unit vector.
%
%==========================================================================
function [e,Phi] = mat2axangle(R)
    
    % principal angle [rad]
    Phi = acos((R(1,1)+R(2,2)+R(3,3)-1)/2);
    
    % principal rotation vector
    e = (1/(2*sin(Phi)))*[R(2,3)-R(3,2);
                          R(3,1)-R(1,3);
                          R(1,2)-R(2,1)];
    
    % normalizes principal rotation vector
    e = e/inorm(e);
    
end