%==========================================================================
%
% rot2  Rotation matrix for a passive rotation about the 2nd axis.
%
%   R2 = rot2(theta)
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
%   R2      - (3×3 double) rotation matrix about 2nd axis (passive)
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