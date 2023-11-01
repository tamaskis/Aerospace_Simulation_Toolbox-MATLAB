%==========================================================================
%
% reverse_transform_position  Transformation of the position of a point
% from a moving frame to a stationary frame.
%
%   r_A2P_A = reverse_transform_position(r_B2P_B,R_A2B,r_A2B_A)
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
%   r_B2P_B - (3×1 double) position of point P with respect to frame B
%             origin, expressed in frame B
%   R_A2B   - (3×3 double) passive rotation matrix from frame A to frame B
%   r_A2B_A - (3×1 double) position of frame B origin with respect to frame
%             A origin, expressed in frame A
%
% -------
% OUTPUT:
% -------
%   r_A2P_A - (3×1 double) position of point P with respect to frame A
%             origin, expressed in frame A
%
%==========================================================================
function r_A2P_A = reverse_transform_position(r_B2P_B,R_A2B,r_A2B_A)
    r_A2P_A = r_A2B_A+(R_A2B.')*r_B2P_B;
end