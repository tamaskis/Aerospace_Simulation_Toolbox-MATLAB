%==========================================================================
%
% axang2eul_321  Axis-angle representation to 3-2-1 Euler angles (yaw, 
% pitch, and roll) (passive rotation).
%
%   [psi,theta,phi] = axang2eul_321(e,Phi)
%
% See also axang2mat, axang2quat, eul2axang_321, eul2mat_321, eul2quat_321,
% mat2axang, mat2eul_321, mat2quat, quat2axang, quat2eul_321, quat2mat.
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
% -----
% NOTE:
% -----
%   • This function normalizes e.
%   • ψ ∈ (-π,π]
%   • θ ∈ [-π/2,π/2]
%   • φ ∈ (-π,π]
%   • When a singularity corresponding to the pitch angles of θ = ±(π/2) is
%     encountered, the yaw angle (ψ) is set to 0 and the roll angle (φ) is
%     determined accordingly.
%
%==========================================================================
function [psi,theta,phi] = axang2eul_321(e,Phi)
    
    % normalizes principal rotation vector
    e = e/inorm(e);
    
    % precomputes trigonometric functions
    c = cos(Phi);
    s = sin(Phi);
    
    % unpacks principal rotation vectors
    e1 = e(1);
    e2 = e(2);
    e3 = e(3);
    
    % R₁₃ element of the rotation matrix
    R13 = e1*e3*(1-c)-e2*s;
    
    % determines if we are in a singular case, and if so, which one
    pitch_up = (R13 <= -1);
    pitch_down = (R13 >= 1);
    singular = (pitch_up || pitch_down);
    
    % yaw angle [rad]
    if singular
        psi = 0;
    else
        psi = iatan2(e1*e2*(1-c)+e3*s,e1^2*(1-c)+c);
    end
    
    % pitch angle [rad]
    if singular
        theta = -(pi/2)*sign(R13);
    else
        theta = -asin(R13);
    end
    
    % roll angle [rad]
    if pitch_up
        phi = iatan2(e2*e1*(1-c)-e3*s,e3*e1*(1-c)+e2*s);
    elseif pitch_down
        phi = -iatan2(e3*e2*(1-c)-e1*s,e2^2*(1-c)+c);
    else
        phi = iatan2(e2*e3*(1-c)+e1*s,e3^2*(1-c)+c);
    end
    
end