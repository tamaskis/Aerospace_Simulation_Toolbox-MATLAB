%==========================================================================
%
% quatslerp  Spherical linear interpolation (SLERP) between two unit
% quaternions.
%
%   q = quatslerp(q1,q2,t)
%
% See also quatang, quatchain, quatconj, quatinv, quatmul, quatnorm,
% quatnormalize, quatrotate.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-05-08
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
%   q1      - (4×1 double) start unit quaternion
%   q2      - (4×1 double) end unit quaternion
%   t       - (1×1 double) interpolation parameter between 0 and 1
%             (inclusive)
%
% -------
% OUTPUT:
% -------
%   q       - (4×1 double) interpolated unit quaternion
%
% -----
% NOTE:
% -----
%   • This function assumes the scalar-first convention for quaternions.
%   • This function assumes that q1 and q2 are input as unit quaternions, 
%     so it does NOT normalize them.
%   • q is normalized.
%   • The scalar part of q is chosen to be positive.
%
%==========================================================================
function q = quatslerp(q1,q2,t)
    
    % half-angle between unit quaternions [rad]
    phi = quatang(q1,q2)/2;
    
    % evaluates trigonometric functions
    a = sin(phi);
    b = sin(t*phi);
    c = sin((1-t)*phi);
    
    % performs SLERP along shorter arc
    if idot(q1,q2) >= 0
        q = (c/a)*q1+(b/a)*q2;
    else
        q = (c/a)*q1-(b/a)*q2;
    end
    
    % normalizes the result
    q = quatnormalize(q);
    
    % ensures scalar part of quaternion is positive
    if q(1) < 0
        q = -q;
    end
    
end