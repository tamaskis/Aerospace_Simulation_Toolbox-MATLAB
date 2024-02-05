%==========================================================================
%
% forward_transform_rot_acc  Acceleration transformation from a stationary
% frame to a rotating frame.
%
%   a_B_B = forward_transform_rot_acc(a_A_A,v_B_B,r_B,R_A2B,omega_A2B_B,...
%       alpha_A2B_B)
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
%   a_A_A       - (3×1 double) acceleration relative to frame A, expressed
%                 in frame A
%   v_B_B       - (3×1 double) velocity relative to frame B, expressed in
%                 frame B
%   r_B         - (3×1 double) position expressed in frame B
%   R_A2B       - (3×3 double) passive rotation matrix from frame A to
%                 frame B
%   omega_A2B_B - (3×1 double) angular velocity of frame B with respect to
%                 frame A, expressed in frame B [rad/s]
%   alpha_A2B_B - (3×1 double) angular acceleration of frame B with respect
%                 to frame A, expressed in frame B [rad/s²]
%
% -------
% OUTPUT:
% -------
%   a_B_B       - (3×1 double) acceleration relative to frame B, expressed
%                 in frame B
%
%==========================================================================
function a_B_B = forward_transform_rot_acc(a_A_A,v_B_B,r_B,R_A2B,...
    omega_A2B_B,alpha_A2B_B)
    
    % term 1
    t1 = cross(omega_A2B_B,r_B);
    
    % term 2
    t2 = cross(omega_A2B_B,t1);
    
    % term 3
    t3 = 2*(cross(omega_A2B_B,v_B_B));
    
    % term 4
    t4 = cross(alpha_A2B_B,r_B);
    
    % term 5
    t5 = R_A2B*a_A_A;
    
    % acceleration relative to frame B, expressed in frame B
    a_B_B = t5-t4-t3-t2;
    
end