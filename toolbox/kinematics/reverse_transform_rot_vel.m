%==========================================================================
%
% reverse_transform_rot_vel  Velocity transformation from a rotating frame 
% to a stationary frame.
%
%   v_A_A = reverse_transform_rot_vel(v_B_B,r_B,R_A2B,omega_A2B_B)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-11-01
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
%   v_B_B       - (3×1 double) velocity relative to frame B, expressed in
%                 frame B
%   r_B         - (3×1 double) position expressed in frame B
%   R_A2B       - (3×3 double) passive rotation matrix from frame A to
%                 frame B
%   omega_A2B_B - (3×1 double) angular velocity of frame B with respect to
%                 frame A, expressed in frame B [rad/s]
%
% -------
% OUTPUT:
% -------
%   v_A_A       - (3×1 double) velocity relative to frame A, expressed in
%                 frame A
%
%==========================================================================
function v_A_A = reverse_transform_rot_vel(v_B_B,r_B,R_A2B,omega_A2B_B)
    v_A_A = (R_A2B.')*(v_B_B+cross(omega_A2B_B,r_B));
end