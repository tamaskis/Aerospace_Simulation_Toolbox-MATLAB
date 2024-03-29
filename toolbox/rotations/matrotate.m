%==========================================================================
%
% matrotate  Passive rotation of a vector by a rotation matrix.
%
%   vB = matrotate(R_A2B,vA)
%
% See also matchain.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-08-13
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
%   R_A2B   - (3×3 double) passive rotation matrix from coordinate frame A
%             to coordinate frame B
%   rA      - (3×1 double) vector expressed in coordinate frame A
%
% -------
% OUTPUT:
% -------
%   rB      - (3×1 double) vector expressed in coordinate frame B
%
%==========================================================================
function rB = matrotate(R_A2B,rA)
    rB = R_A2B*rA;
end