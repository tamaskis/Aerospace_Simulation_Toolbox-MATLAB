%==========================================================================
%
% rot3  Rotation matrix for a passive rotation about the 3rd axis.
%
%   R3 = rot3(theta)
%
% See also rot1, rot2, rot313, rot321.
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
%   theta   - (1×1 double) angle of rotation [rad]
%
% -------
% OUTPUT:
% -------
%   R3      - (3×3 double) rotation matrix about 3rd axis (passive)
%
%==========================================================================
function R3 = rot3(theta)
    
    % precomputes trigonometric functions
    c = cos(theta);
    s = sin(theta);
    
    % constructs rotation matrix
    R3 = [ c   s   0;
          -s   c   0;
           0   0   1];
    
end