%==========================================================================
%
% dcm2quat  Direction cosine matrix (DCM) to quaternion.
%
%   q = dcm2quat(A)
%
% Copyright (c) 2021 Tamas Kis
% Last Update: 2021-06-01
%
%--------------------------------------------------------------------------
%
% -------
% INPUTS:
% -------
%   A       (3x3) direction cosine matrix
%
% --------
% OUTPUTS:
% --------
%   q       (4x1) quaternion
%
%==========================================================================
function q = dcm2quat(A)

    % quaternion elements
    q1 = 0.5*sqrt(1+2*A(1,1)-trace(A));
    q2 = 0.5*sqrt(1+2*A(2,2)-trace(A));
    q3 = 0.5*sqrt(1+2*A(3,3)-trace(A));
    q4 = 0.5*sqrt(1+trace(A));
    
    % finds maximum element of quaternion
    [q_max,i_max] = max([q1,q2,q3,q4]);
    
    % updates elements of quaternion
    switch i_max
        case 1
            q1 = q_max;
            q2 = (A(1,2)+A(2,1))/(4*q1);
            q3 = (A(1,3)+A(3,1))/(4*q1);
            q4 = (A(2,3)-A(3,2))/(4*q1);
        case 2
            q2 = q_max;
            q1 = (A(1,2)+A(2,1))/(4*q2);
            q3 = (A(2,3)+A(3,2))/(4*q2);
            q4 = (A(3,1)-A(1,3))/(4*q2);
        case 3
            q3 = q_max;
            q1 = (A(1,3)+A(3,1))/(4*q3);
            q2 = (A(2,3)+A(3,2))/(4*q3);
            q4 = (A(1,2)-A(2,1))/(4*q3);
        case 4
            q4 = q_max;
            q1 = (A(2,3)-A(3,2))/(4*q4);
            q2 = (A(3,1)-A(1,3))/(4*q4);
            q3 = (A(1,2)-A(2,1))/(4*q4);
    end
    
    % packages quaternion
    q = [q1;q2;q3;q4];

end