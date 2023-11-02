%==========================================================================
%
% forward_transform_mov_acc  Acceleration transformation from a stationary
% frame to a moving (rotating + translating) frame.
%
%   a_B2P_B_B = forward_transform_mov_acc(a_A2P_A_A,v_B2P_B_B,r_B2P_B,...
%       R_A2B,omega_A2B_B,alpha_A2B_B,a_A2B_A_A)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-10-31
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
%   a_A2P_A_A   - (3×1 double) acceleration of point P with respect to
%                 frame A origin, relative to frame A, expressed in frame A
%   v_B2P_B_B   - (3×1 double) velocity of point P with respect to frame B
%                 origin, relative to frame B, expressed in frame B
%   r_B2P_B     - (3×1 double) position of point P with respect to frame B
%                 origin, expressed in frame B
%   R_A2B       - (3×3 double) passive rotation matrix from frame A to
%                 frame B
%   omega_A2B_B - (3×1 double) angular velocity of frame B with respect to
%                 frame A, expressed in frame B [rad/s]
%   alpha_A2B_B - (3×1 double) angular acceleration of frame B with respect
%                 to frame A, expressed in frame B [rad/s²]
%   a_A2B_A_A   - (3×1 double) acceleration of frame B origin with respect
%                 to frame A origin, relative to frame A, expressed in
%                 frame A
%
% -------
% OUTPUT:
% -------
%   a_B2P_B_B   - (3×1 double) acceleration of point P with respect to
%                 frame B origin, relative to frame B, expressed in frame B
%
%==========================================================================
function a_B2P_B_B = forward_transform_mov_acc(a_A2P_A_A,v_B2P_B_B,...
    r_B2P_B,R_A2B,omega_A2B_B,alpha_A2B_B,a_A2B_A_A)
    
    % term 1
    t1 = cross(omega_A2B_B,r_B2P_B);
    
    % term 2
    t2 = cross(omega_A2B_B,t1);
    
    % term 3
    t3 = 2*(cross(omega_A2B_B,v_B2P_B_B));
    
    % term 4
    t4 = cross(alpha_A2B_B,r_B2P_B);
    
    % term 5
    t5 = R_A2B*(a_A2P_A_A-a_A2B_A_A);
    
    % acceleration of point P with respect to frame B origin, relative to
    % frame B, expressed in frame B
    a_B2P_B_B = t5-t4-t3-t2;
    
end