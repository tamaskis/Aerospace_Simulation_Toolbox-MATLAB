%==========================================================================
%
% forward_transform_rot_pos  Position transformation from a stationary
% frame to a rotating frame.
%
%   r_B = forward_transform_rot_pos(r_A,R_A2B)
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
%   r_A     - (3×1 double) position expressed in frame A
%   R_A2B   - (3×3 double) passive rotation matrix from frame A to frame B
%
% -------
% OUTPUT:
% -------
%   r_B     - (3×1 double) position expressed in frame B
%
%==========================================================================
function r_B = forward_transform_rot_pos(r_A,R_A2B)
    r_B = R_A2B*r_A;
end