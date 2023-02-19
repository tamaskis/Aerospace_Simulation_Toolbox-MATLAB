%==========================================================================
%
% eul2quat313  3-1-3 Euler angles to quaternion.
%
%   q = eul2quat313(phi,theta,psi)
%
% Copyright (c) 2021 Tamas Kis
% Last Update: 2021-06-01
%
%--------------------------------------------------------------------------
%
% -------
% INPUTS:
% -------
%   phi     (1x1) [rad] 3-1-3 Euler angle
%   theta   (1x1) [rad] 3-1-3 Euler angle
%   psi     (1x1) [rad] 3-1-3 Euler angle
%
% --------
% OUTPUTS:
% --------
%   q       (4x1) quaternion
%
%==========================================================================
function q = eul2quat313(phi,theta,psi)

    % calculates quaternion elements
    q1 = sin(theta/2)*cos((phi-psi)/2);
    q2 = sin(theta/2)*sin((phi-psi)/2);
    q3 = cos(theta/2)*sin((phi+psi)/2);
    q4 = cos(theta/2)*cos((phi+psi)/2);
    
    % packages quaternion
    q = [q1;q2;q3;q4];
 
end