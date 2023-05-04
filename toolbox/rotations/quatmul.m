%==========================================================================
%
% quatmul  Quaternion multiplication (Hamilton product).
%
%   pq = quatmul(p,q)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-23
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
%   p       - (4×1 double) unit quaternion
%   q       - (4×1 double) unit quaternion
%
% -------
% OUTPUT:
% -------
%   pq      - (4×1 double) Hamilton product of p and q
%
%==========================================================================
function pq = quatmul(p,q)
    
    % evaluate the Hamilton product
    pq = [p(1)*q(1)-p(2)*q(2)-p(3)*q(3)-p(4)*q(4);
          p(1)*q(2)+q(2)*q(1)+p(3)*q(4)-p(4)*q(3);
          p(1)*q(3)-p(2)*q(4)+p(3)*q(1)+p(4)*q(2);
          p(1)*q(4)+p(2)*q(3)-p(3)*q(2)+p(4)*q(1)];
    
    % normalize the result
    pq = quatnormalize(pq);
    
end