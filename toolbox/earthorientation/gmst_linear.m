%==========================================================================
%
% gmst_linear  Greenwich mean sidereal time (GMST) (linear model for GMST).
%
%   GMST = gmst_linear(MJD_UT1)
%
% See also gmst_iau06, gmst_vallado.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] D'Amico, "Earth Rotation and Time Systems", AA 279A Lecture 6
%       Slides, Slide 4
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UT1	- (1×1 double) UT1 (Universal Time 1) [MJD]
%
% -------
% OUTPUT:
% -------
%   GMST    - (1×1 double) Greenwich mean sidereal time [rad]
%
%==========================================================================
function GMST = gmst_linear(MJD_UT1)
    
    % GMST in degrees
    GMST = 280.4606+360.9856473*(MJD_UT1-51544.5);
    
    % convert GMST to radians
    GMST = deg2rad(GMST);

    % wrap GMST to the interval [0,2π)
    GMST = mod(GMST,2*pi);
    
end