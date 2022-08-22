%==========================================================================
%
% M2tof  Time of flight between two mean anomalies.
%
%   TOF = M2tof(M0,M,n)
%   TOF = M2tof(M0,M,n,k)
%
% See also tof2M.
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
%   M0   	- (1×1 double) initial mean anomaly [rad]
%   M       - (1×1 double) current/final mean anomaly [rad]
%   n       - (1×1 double) mean motion [rad/s]
%   k       - (1×1 double) (OPTIONAL) integer number of completed orbits 
%             (defaults to 0)
%
% -------
% OUTPUT:
% -------
%   TOF     - (1×1 double) time of flight [s]
%
% -----
% NOTE:
% -----
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function TOF = M2tof(M0,M,n,k)

    % defaults "k" to 0 if not input
    if (nargin < 4) || isempty(k)
        k = 0;
    end

    % time of flight [s]
    TOF = ((M-M0)+2*pi*k)/n;
    
end