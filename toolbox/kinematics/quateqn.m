%==========================================================================
%
% quateqn  Quaternion kinematic equation.
%
%   dq_world2body = quateqn(q_world2body,w_world2body_body)
%
% See also matderiv.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-06-12
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
%   q_world2body        - (4×1 double) unit quaternion representing the
%                         passive rotation from the world frame to the body
%                         frame
%   w_world2body_body   - (3×1 double) angular velocity of the body frame
%                         with respect to the world frame, expressed in the
%                         body frame [rad/s]
%
% -------
% OUTPUT:
% -------
%   dq_world2body       - (4×1 double) derivative of the input unit
%                         quaternion [1/s]
%   
% -----
% NOTE:
% -----
%   • This function assumes the scalar-first convention for quaternions.
%   • This function normalizes the input quaternion.
%
%==========================================================================
function dq_world2body = quateqn(q_world2body,w_world2body_body)
    
    % normalizes quaternion
    q_world2body = quatnormalize(q_world2body);
    
    % unpacks unit quaternion
    q0 = q_world2body(1);
    q1 = q_world2body(2);
    q2 = q_world2body(3);
    q3 = q_world2body(4);
    
    % unpacks angular velocity vector
    p = w_world2body_body(1);
    q = w_world2body_body(2);
    r = w_world2body_body(3);
    
    % % quaternion derivative
    dq_world2body = 0.5*[-p*q1-q*q2-r*q3;
                          p*q0-q*q3+r*q2;
                          p*q3+q*q0-r*q1;
                         -p*q2+q*q1+r*q0];
    
end