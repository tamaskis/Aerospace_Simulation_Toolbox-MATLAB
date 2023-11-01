%==========================================================================
%
% reverse_transform_vel  Transformation of the velocity of a point from a
% moving frame to a stationary frame.
%
%   v_A2P_A_A = reverse_transform_vel(v_B2P_B_B,r_B2P_B,R_A2B,...
%       omega_A2B_B,v_A2B_A_A)
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
%   v_B2P_B_B   - (3×1 double) velocity of point P with respect to frame B
%                 origin, relative to frame B, expressed in frame B
%   r_B2P_B     - (3×1 double) position of point P with respect to frame B
%                 origin, expressed in frame B
%   R_A2B       - (3×3 double) passive rotation matrix from frame A to
%                 frame B
%   omega_A2B_B - (3×1 double) angular velocity of frame B with respect to
%                 frame A, expressed in frame B [rad/s]
%   v_A2B_A_A   - (3×1 double) velocity of frame B origin with respect to
%                 frame A origin, relative to frame A, expressed in frame A
%
% -------
% OUTPUT:
% -------
%   v_A2P_A_A   - (3×1 double) velocity of point P with respect to frame A
%                 origin, relative to frame A, expressed in frame A
%
%==========================================================================
function v_A2P_A_A = reverse_transform_vel(v_B2P_B_B,r_B2P_B,R_A2B,...
    omega_A2B_B,v_A2B_A_A)
    v_A2P_A_A = v_A2B_A_A+(R_A2B.')*(v_B2P_B_B+cross(omega_A2B_B,r_B2P_B));
end