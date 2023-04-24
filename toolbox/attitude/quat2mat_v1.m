%==========================================================================
%
% quat2dcm  Quaternion to direction cosine matrix (DCM).
%
%   A = quat2dcm(q)
%
% Copyright (c) 2021 Tamas Kis
% Last Update: 2021-06-01
%
%--------------------------------------------------------------------------
%
% -------
% INPUTS:
% -------
%   q   (4x1) quaternion
%
% --------
% OUTPUTS:
% --------
%   A   (3x3) direction cosine matrix
%
%==========================================================================
function A = quat2mat_v1(q)
    
    % unpacks quaternion
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);
    
    % direction cosine matrix
    A = [q1^2-q2^2-q3^2+q4^2    2*(q1*q2+q3*q4)       2*(q1*q3-q2*q4);
         2*(q1*q2-q3*q4)       -q1^2+q2^2-q3^2+q4^2   2*(q2*q3+q1*q4);
         2*(q1*q3+q2*q4)        2*(q2*q3-q1*q4)      -q1^2-q2^2+q3^2+q4^2];
    
end