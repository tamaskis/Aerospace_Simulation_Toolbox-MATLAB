%==========================================================================
%
% rot321  Rotation matrix for the 3-2-1 rotation sequence.
%
%   R321 = rot321(theta1,theta2,theta3)
%
% See also rot1, rot2, rot3, rot313.
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
%   theta1  - (1×1 double) angle for 1st rotation (about 3rd axis) [rad]
%   theta2  - (1×1 double) angle for 2nd rotation (about 2nd axis) [rad]
%   theta3  - (1×1 double) angle for 3rd rotation (about 1st axis) [rad]
%
% -------
% OUTPUT:
% -------
%   R321    - (3×3 double) rotation matrix for 3-2-1 rotation sequence
%
%==========================================================================
function R321 = rot321(theta1,theta2,theta3)
    
    % precomputes trigonometric functions
    s1 = sin(theta1);
    c1 = cos(theta1);
    s2 = sin(theta2);
    c2 = cos(theta2);
    s3 = sin(theta3);
    c3 = cos(theta3);
    
    % constructs rotation matrix
    R321 = [ c2*c1            c2*s1           -s2;
            -c3*s1+s3*s2*c1   c3*c1+s3*s2*s1   s3*c2;
             s3*s1+c3*s2*c1  -s3*c1+c3*s2*s1   c3*c2];
    
end