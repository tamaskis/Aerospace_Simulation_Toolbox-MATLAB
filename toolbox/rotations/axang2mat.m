%==========================================================================
%
% axang2mat  Axis-angle representation to rotation matrix.
%
%   R = axang2mat(e,Phi)
%
% See also axangle2eul_321, axang2quat, eul2axang_321, eul2mat_321,
% eul2quat_321, mat2axang, mat2eul_321, mat2quat, quat2axang, quat2eul_321,
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
%   e       - (3×1 double) principal rotation vector
%   Phi     - (1×1 double) principal angle [rad]
%
% -------
% OUTPUT:
% -------
%   R       - (3×3 double) rotation matrix
%
% -----
% NOTE:
% -----
%   • e does not have to be input as a unit vector.
%
%==========================================================================
function R = axang2mat(e,Phi)
    
    % normalizes principal rotation vector
    e = e/inorm(e);
    
    % precomputes trigonometric functions
    c = cos(Phi);
    s = sin(Phi);
    
    % auxiliary parameter
    a = 1-c;
    
    % rotation matrix
    R = [e(1)^2*a+c           e(1)*e(2)*a+e(3)*s   e(1)*e(3)*a-e(2)*s;
         e(2)*e(1)*a-e(3)*s   e(2)^2*a+c           e(2)*e(3)*a+e(1)*s;
         e(3)*e(1)*a+e(2)*s   e(3)*e(2)*a-e(1)*s   e(3)^2*a+c];
    
end