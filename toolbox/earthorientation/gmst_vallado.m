%==========================================================================
%
% gmst_vallado  Greenwich mean sidereal time (GMST) (from "Fundamentals of 
% Astrodynamics and Applications" by Vallado).
%
%   GMST = gmst_vallado(MJD_UT1)
%
% See also gmst_iau06, gmst_linear.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (3-47) (p. 188)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UT1 - (1×1 double) UT1 (Universal Time 1) [MJD]
%
% -------
% OUTPUT:
% -------
%   GMST    - (1×1 double) Greenwich mean sidereal time [rad]
%
%==========================================================================
function GMST = gmst_vallado(MJD_UT1)

    % Julian centuries since J2000.0 of UT1 [c]
    T_UT1 = mjd2t(MJD_UT1);
    
    % GMST [rad]
    GMST = (pi/43200)*(67310.54841+3164400184.812866*T_UT1+0.093104*...
        T_UT1^2-(6.2e-6)*T_UT1^3);
    
    % wrap GMST to the interval [0,2π)
    GMST = mod(GMST,2*pi);
    
end