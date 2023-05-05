%==========================================================================
%
% quatmul  Quaternion multiplication (Hamilton product).
%
%   r = quatmul(p,q)
%
% See also quatchain, quatconj, quatinv, quatnorm, quatnormalize.
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
%   p       - (4×1 double) quaternion
%   q       - (4×1 double) quaternion
%
% -------
% OUTPUT:
% -------
%   r       - (4×1 double) Hamilton product of p and q
% 
% -----
% NOTE:
% -----
%   • This function assumes the scalar-first convention for quaternions.
%   • p and q do not have to be input as unit quaternions, and r is not 
%     returned as a unit quaternion.
%     
%==========================================================================
function r = quatmul(p,q)
    r = [p(1)*q(1)-p(2)*q(2)-p(3)*q(3)-p(4)*q(4);
         p(1)*q(2)+p(2)*q(1)+p(3)*q(4)-p(4)*q(3);
         p(1)*q(3)-p(2)*q(4)+p(3)*q(1)+p(4)*q(2);
         p(1)*q(4)+p(2)*q(3)-p(3)*q(2)+p(4)*q(1)];
end