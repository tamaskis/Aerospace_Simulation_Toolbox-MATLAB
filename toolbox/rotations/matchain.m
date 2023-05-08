%==========================================================================
%
% matchain  Chaining passive rotations represented by rotation matrices.
%
%   R_A2C = matchain(R_A2B,R_B2C)
%
% See also matrotate.
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
%   R_A2B   - (3×3 double) rotation matrix representing rotation from frame
%             A to frame B
%   R_B2C   - (3×3 double) rotation matrix representing rotation from frame
%             B to frame C
%
% -------
% OUTPUT:
% -------
%   R_A2C   - (3×3 double) rotation matrix representing rotation from frame
%             A to frame C
%     
%==========================================================================
function R_A2C = matchain(R_A2B,R_B2C)
    R_A2C = R_B2C*R_A2B;
end