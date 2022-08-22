%==========================================================================
%
% tof2M  Mean anomaly from time of flight.
%
%   M = tof2M(M0,n,TOF)
%   M = tof2M(M0,n,t,t0)
%
% See also M2tof.
%
% Author: Tamas Kis
% Last Update: 2022-02-05
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (2-7) (p. 46)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   M0      - (1×1 double) initial mean anomaly [rad]
%   n       - (1×1 double) mean motion [rad/s]
%   t       - (1×1 double) current time (or time of flight if t0 = 0) [s]
%   t0      - (1×1 double) (OPTIONAL) initial time (defaults to 0) [s]
%
% -------
% OUTPUT:
% -------
%   M       - (1×1 double) current mean anomaly [rad]
%   k       - (1×1 double) integer number of completed orbits [-]
%
% -----
% NOTE:
% -----
%   --> If "t0" is not input, it is assumed that "t" represents the time of 
%       flight since "M0".
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function [M,k] = tof2M(M0,n,t,t0)

    % defaults "t0" to 0 if not input
    if (nargin < 4) || isempty(t0)
        t0 = 0;
    end

    % mean anomaly [rad]
    M = mod(M0+n*(t-t0),2*pi);

    % integer number of completed orbits
    k = floor((M-M0)/(2*pi));

end