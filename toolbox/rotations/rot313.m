%==========================================================================
%
% rot313  Rotation matrix for the 3-1-3 Euler rotation sequence.
%
%   R313 = rot313(psi,theta,phi)
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
%   theta   - (1×1 double) angle for 2nd rotation (about 1st axis) [rad]
%   phi     - (1×1 double) angle for 3rd rotation (about 3rd axis) [rad]
%
% -------
% OUTPUT:
% -------
%   R313    - (3×3 double) rotation matrix for 3-1-3 Euler rotation
%             sequence
%
%==========================================================================
function R313 = rot313(psi,theta,phi)
    
    % precomputes trigonometric functions
    sp = sin(psi);
    cp = cos(psi);
    st = sin(theta);
    ct = cos(theta);
    sf = sin(phi);
    cf = cos(phi);

    % 3-1-3 rotation matrix
    R313 = [ cf*cp-sf*ct*sp   cf*sp+sf*ct*cp   sf*st;
            -sf*cp-cf*ct*sp  -sf*sp+cf*ct*cp   cf*st;
             st*sp           -st*cp            ct];

end