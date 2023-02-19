%==========================================================================
%
% quat2eul313  Quaternion to 3-1-3 Euler angles.
%
%   [phi,theta,psi] = quat2eul313(q)
%
% Copyright (c) 2021 Tamas Kis
% Last Update: 2021-05-31
%
%--------------------------------------------------------------------------
%
% -------
% INPUTS:
% -------
%   q       (4x1) quaternion
%
% --------
% OUTPUTS:
% --------
%   phi     (1x1) [rad] 3-1-3 Euler angle
%   theta   (1x1) [rad] 3-1-3 Euler angle
%   psi     (1x1) [rad] 3-1-3 Euler angle
%
%==========================================================================
function [phi,theta,psi] = quat2eul313(q)

    % unpacks quaternion
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    % 3-1-3 Euler angles [rad]
    phi = mod(atan2(q1*q3+q2*q4,q1*q4-q2*q3),2*pi);
    theta = acos(-q1^2-q2^2+q3^2+q4^2);
    psi = mod(atan2(q1*q3-q2*q4,q2*q3+q1*q4),2*pi);
    
end