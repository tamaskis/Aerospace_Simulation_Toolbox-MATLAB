%==========================================================================
%
% quatchain  Chaining rotations represented by unit quaternions.
%
%   q_A2C = quatchain(q_A2B,q_B2C)
%
% See also quatchain, quatconj, quatinv, quatmul, quatnorm, quatnormalize.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-05-04
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
%   q_B2C   - (4×1 double) unit quaternion representing rotation from frame
%             B to frame C
%
% -------
% OUTPUT:
% -------
%   q_A2C   - (4×1 double) unit quaternion representing rotation from frame
%             A to frame C
% 
% -----
% NOTE:
% -----
%   • This function assumes the scalar-first convention for quaternions.
%   • It is assumed that q_A2B and q_B2C are input as unit quaternions.
%   • q_A2C is returned as a unit quaternion.
%   • The scalar component of q_A2C is chosen to be positive.
%     
%==========================================================================
function q_A2C = quatchain(q_A2B,q_B2C)
    
    % evaluates Hamilton product to find chained rotation
    q_A2C = quatmul(q_A2B,q_B2C);
    
    % normalizes the result
    q_A2C = quatnormalize(q_A2C);
    
end