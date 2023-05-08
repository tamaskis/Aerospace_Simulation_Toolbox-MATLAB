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
%   q1      - (4×1 double) start unit quaternion
%   q2      - (4×1 double) end unit quaternion
%   t       - (1×1 double) interpolation parameter between 0 and 1
%             (inclusive)
%
% -------
% OUTPUT:
% -------
%   q       - (1×1 double) interpolated unit quaternion
%
% -----
% NOTE:
% -----
%   • This function assumes that q1 and q2 are input as unit quaternions, 
%     so it does NOT normalize them.
%   • q is normalized.
%
%==========================================================================
function q = quatslerp(q1,q2,t)
    
    % angle between unit quaternions [rad]
    phi = quatang(q1,q2);
    
    % defines angle to interpolate along shorter arc [rad]
    if phi > (pi/2)
        theta = pi-phi;
    else
        theta = phi;
    end
    
    % evaluates trigonometric functions
    a = sin(theta);
    b = sin(t*theta);
    c = sin((1-t)*theta);
    
    % auxiliary parameters
    d = c/a;
    e = b/a;
    
    % performs SLERP along shorter arc
    if phi > (pi/2)
        q = d*q1-e*q2;
    else
        q = d*q1+e*q2;
    end

    % normalizes the result
    q = quatnormalize(q);
    
end