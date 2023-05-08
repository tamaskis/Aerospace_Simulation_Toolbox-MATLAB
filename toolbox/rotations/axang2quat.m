%==========================================================================
%
% axang2quat  Axis-angle representation to unit quaternion.
%
%   q = axang2quat(e,Phi)
%
% See also axangle2eul_321, axang2mat, eul2axang_321, eul2mat_321,
% eul2quat_321, mat2axang, mat2eul_321, mat2quat, quat2axang, quat2eul_321,
% quat2mat.
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
%   q       - (4×1 double) unit quaternion
%
% -----
% NOTE:
% -----
%   • This function normalizes e.
%   • This function assumes the scalar-first convention for quaternions.
%   • The scalar component, q₀, is chosen to be positive.
%
%==========================================================================
function q = axang2quat(e,Phi)
    
    % normalizes principal rotation vector
    e = e/inorm(e);
    
    % determines quaternion
    q = [cos(Phi/2);
         sin(Phi/2)*e];
    
    % ensures scalar component of quaternion is positive
    if q(1) < 0
        q = -q;
    end
    
    % normalizes quaternion
    q = quatnormalize(q);
    
end