%==========================================================================
%
% rot1  Rotation matrix for a passive rotation about the 1st axis.
%
%   R1 = rot1(theta)
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
%   R1      - (3×3 double) rotation matrix about 1st axis (passive)
%
%==========================================================================
function R1 = rot1(theta)
    R1 = [1   0            0;
          0   cos(theta)   sin(theta);
          0  -sin(theta)   cos(theta)];
end