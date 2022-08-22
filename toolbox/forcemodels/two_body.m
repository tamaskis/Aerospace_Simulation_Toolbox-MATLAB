%==========================================================================
%
% two_body  Two-body/Keplerian gravitational acceleration.
%
%   g_kep = two_body(r)
%
% See also gravity, J2_ecef, J2_rtn.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (1-14) (pp. 23)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r       - (3×1 double) position [m]
%
% -------
% OUTPUT:
% -------
%   g_kep   - (3×1 double) (inertial) acceleration due to gravity [m/s^2]
%
% -----
% NOTE:
% -----
%   --> "r" must be defined in a geocentric coordinate frame.
%
%==========================================================================
function g_kep = two_body(r)
    
    % Earth gravitational parameter [m^3/s^2]
    mu = MU_EARTH;

    % Two-body/Keplerian gravitational acceleration [m/s^2]
    g_kep = -mu*(r/inorm(r)^3);

end