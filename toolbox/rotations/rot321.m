%==========================================================================
%
% rot321  Rotation matrix for the 3-2-1 Euler rotation sequence.
%
%   R321 = rot321(psi,theta,phi)
%
% Author: Tamas Kis
% Last Update: 2022-01-05
%
% REFERENCES:
%   [1] Wertz, "Spacecraft Attitude Determination and Control" 
%       (pp. 763-764)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   psi     - (1×1 double) angle for 1st rotation (about 3rd axis) [rad]
%   theta   - (1×1 double) angle for 2nd rotation (about 2nd axis) [rad]
%   phi     - (1×1 double) angle for 3rd rotation (about 1st axis) [rad]
%
% -------
% OUTPUT:
% -------
%   R321    - (3×3 double) rotation matrix for 3-2-1 Euler rotation
%             sequence
%
%==========================================================================
function R321 = rot321(psi,theta,phi)
    
    % precomputes trigonometric functions
    sp = sin(psi);
    cp = cos(psi);
    st = sin(theta);
    ct = cos(theta);
    sf = sin(phi);
    cf = cos(phi);

    % 3-2-1 rotation matrix
    R321 = [ ct*cp            ct*sp           -st;
            -cf*sp+sf*st*cp   cf*cp+sf*st*sp   sf*ct;
             sf*sp+cf*st*cp  -sf*cp+cf*st*sp   cf*ct];

end