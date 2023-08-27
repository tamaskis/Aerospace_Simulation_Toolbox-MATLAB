%==========================================================================
%
% matderiv  Time derivative of a passive rotation matrix.
%
%   dRdt = matderiv(R_A2B,omega_A2B_B)
%
% See also quateqn.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-08-12
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
%   R_A2B       - (3×3 double) passive rotation matrix from frame A to
%                 frame B
%   omega_A2B_B - (3×1 double) angular velocity of frame B with respect to
%                 frame A, expressed in frame B [rad/s]
%
% -------
% OUTPUT:
% -------
%   dRdt        - (3×3 double) time derivative of the passive rotation
%                 matrix from frame A to frame B [1/s]
%
%==========================================================================
function dRdt = matderiv(R_A2B,w_A2B_B)
    
    % skew-symmetric form of the angular velocity [rad/s]
    W = vec2skew(w_A2B_B);
    
    % time derivative of the passive rotation matrix [1/s]
    dRdt = -W*R_A2B;
    
end