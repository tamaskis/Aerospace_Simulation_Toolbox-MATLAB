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
function R = quat2mat_v2(q)
    q0 = q(1);
    q1 = q(2);
    q2 = q(3);
    q3 = q(4);
    a = q0^2;
    b = q1^2;
    c = q2^2;
    d = q3^2;
    e = q1*q2;
    f = q0*q3;
    g = q1*q3;
    h = q0*q2;
    k = q2*q3;
    R = [a+b-c-d,2*(e+f),2*(g-h);
         2*(e-f),a-b+c-d,2*(k+h);
         2*(g+h),2*(k-q0*q1),a-b-c+d];
end