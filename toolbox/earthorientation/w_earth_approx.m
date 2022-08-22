%==========================================================================
%
% w_earth_approx  Angular velocity of the Earth resolved in the ECI frame 
% (approximate).
%
%   w_eci = w_earth_approx
%
% See also w_earth_iau06.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
%--------------------------------------------------------------------------
%
% -------
% OUTPUT:
% -------
%   w_eci - (3×1 double) Earth angular velocity resolved in ECI frame 
%           [rad/s]
%
%==========================================================================
function w_eci = w_earth_approx
    
    % Earth rotational speed [rad/s]
    w_earth = W_EARTH;

    % Earth angular velocity resolved in ECI frame [rad/s]
    w_eci = [0;
             0;
             w_earth];
    
end