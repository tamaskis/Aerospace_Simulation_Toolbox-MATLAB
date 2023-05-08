%==========================================================================
%
% quatrotate  Passive rotation of a vector by a unit quaternion.
%
%   rB = quatrotate(q_A2B,rA)
%
% See also quatang, quatchain, quatconj, quatinv, quatmul, quatnorm,
% quatnormalize, quatslerp.
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
%   q_A2B   - (4×1 double) unit quaternion representing rotation from frame
%             A to frame B
%   rA      - (3×1 double) vector expressed in coordinate frame A
%
% -------
% OUTPUT:
% -------
%   rB      - (3×1 double) vector expressed in coordinate frame B
% 
% -----
% NOTE:
% -----
%   • This function assumes the scalar-first convention for quaternions.
%   • This function normalizes the input quaternion.
%     
%==========================================================================
function rB = quatrotate(q_A2B,rA)
    rB = matrotate(quat2mat(q_A2B),rA);
end