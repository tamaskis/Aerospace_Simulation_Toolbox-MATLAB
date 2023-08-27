%==========================================================================
%
% rot2  Rotation matrix for a passive rotation about the 2nd axis.
%
%   R2 = rot2(theta)
%
% See also rot1, rot3, rot313, rot321.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-08-13
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
%   R2      - (3×3 double) passive rotation matrix about 2nd axis
%
%==========================================================================
function R2 = rot2(theta)
    
    % precomputes trigonometric functions
    c = cos(theta);
    s = sin(theta);
    
    % constructs rotation matrix
    R2 = [c   0  -s;
          0   1   0;
          s   0   c];
    
end