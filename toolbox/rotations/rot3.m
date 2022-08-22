%==========================================================================
%
% rot3  Rotation matrix for a passive rotation about the 3rd axis.
%
%   R3 = rot3(theta)
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
%   R3      - (3×3 double) rotation matrix about 3rd axis (passive)
%
%==========================================================================
function R3 = rot3(theta)
    R3 = [ cos(theta)   sin(theta)   0;
          -sin(theta)   cos(theta)   0;
           0            0            1];
end