%==========================================================================
%
% rot1  Rotation matrix for a passive rotation about the 1st axis.
%
%   R1 = rot1(theta)
%
% See also rot2, rot3, rot313, rot321.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-02-19
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
%   R1      - (3×3 double) rotation matrix about 1st axis (passive)
%
%==========================================================================
function R1 = rot1(theta)
    
    % precomputes trigonometric functions
    c = cos(theta);
    s = sin(theta);
    
    % constructs rotation matrix
    R1 = [1   0   0;
          0   c   s;
          0  -s   c];
    
end