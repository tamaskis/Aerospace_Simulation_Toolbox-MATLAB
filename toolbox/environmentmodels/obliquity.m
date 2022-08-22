%==========================================================================
%
% obliquity  Obliquity of the ecliptic.
%
%   epsilon = obliquity(MJD_TT)
%
% See also eclipse, moon_position, sun_position.
%
% Author: Tamas Kis
% Last Update: 2022-02-20
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (3-68) (p. 216)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_TT  - (1×1 double) TT (Terrestrial Time) [MJD]
%
% -------
% OUTPUT:
% -------
%   epsilon - (1×1 double) obliquity of the ecliptic [rad]
%
%==========================================================================
function epsilon = obliquity(MJD_TT)

    % Julian centuries since J2000.0 of TT [c]
    T_TT = mjd2t(MJD_TT);

    % obliquity in degrees
    epsilon = 23.439279-(0.0130102*T_TT)-((5.086e-8)*T_TT^2)+...
        ((5.565e-7)*T_TT^3)+((1.6e-10)*T_TT^4)+((1.25e-11)*T_TT^5);
    
    % converts obliquity to radians
    epsilon = deg2rad(epsilon);
    
end