%==========================================================================
%
% rot2  Rotation matrix for a passive rotation about the 2nd axis.
%
%   R2 = rot2(theta)
%
% Author: Tamas Kis
% Last Update: 2022-01-05
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (p. 162)
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
    R2 = [cos(theta)   0  -sin(theta);
          0            1   0;
          sin(theta)   0   cos(theta)];
end