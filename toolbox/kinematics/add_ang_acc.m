%==========================================================================
%
% add_ang_acc  Addition of angular accelerations.
%
%   alpha_A2C_C = add_ang_acc(omega_A2B_B,alpha_A2B_B,omega_B2C_C,
%       alpha_B2C_C,R_B2C)
%
% See also add_ang_vel.
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
%   omega_A2B_B - (3×1 double) angular velocity of frame B with respect to
%                 frame A, expressed in frame B [rad/s]
%   alpha_A2B_B - (3×1 double) angular acceleration of frame B with respect
%                 to frame A, expressed in frame B [rad/s²]
%   omega_B2C_C - (3×1 double) angular velocity of frame C with respect to
%                 frame B, expressed in frame C [rad/s]
%   alpha_B2C_C - (3×1 double) angular acceleration of frame C with respect
%                 to frame B, expressed in frame C [rad/s²]
%   R_B2C       - (3×3 double) passive rotation matrix from frame B to
%                 frame C
%
% -------
% OUTPUT:
% -------
%   alpha_A2C_C - (3×3 double) angular acceleration of frame C with respect
%                 to frame A, expressed in frame C [rad/s²]
%
%==========================================================================
function alpha_A2C_C = add_ang_acc(omega_A2B_B,alpha_A2B_B,...
    omega_B2C_C,alpha_B2C_C,R_B2C)
    alpha_A2C_C = R_B2C*alpha_A2B_B+alpha_B2C_C+cross(R_B2C*omega_A2B_B,...
        omega_B2C_C);
end