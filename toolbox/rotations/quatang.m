%==========================================================================
%
% quatang  Angle between two unit quaternions.
%
%   theta = quatang(q1,q2)
%
% See also quatchain, quatconj, quatinv, quatmul, quatnorm, quatnormalize,
% quatrotate, quatslerp.
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
%   q1      - (4×1 double) unit quaternion
%   q2      - (4×1 double) unit quaternion
%
% -------
% OUTPUT:
% -------
%   theta   - (1×1 double) angle between the two unit quaternions [rad]
%
% -----
% NOTE:
% -----
%   • This function assumes that q1 and q2 are input as unit quaternions, 
%     so it does NOT normalize them.
%   • This function returns the smaller of the two angles between the unit
%     quaternions, such that θ ∈ [0,π].
%
%==========================================================================
function theta = quatang(q1,q2)
    
    % angle between the unit quaternions [rad]
    theta = 4*iatan2(quatnorm(q1-q2),quatnorm(q1+q2));
    
    % adjusts angle to ensure shortest arc is used
    if theta > pi
        theta = 2*pi-theta;
    end
    
end