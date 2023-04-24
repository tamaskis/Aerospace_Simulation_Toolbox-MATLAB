%==========================================================================
%
% f2hms  Hours, minutes, and seconds from fraction of day.
%
%   [hh,mm,ss] = f2hms(f_DD)
%
% See also cal2doy, cal2mjd, doy2cal, hms2f, jd2mjd, jd2t, mjd2cal, mjd2f,
% mjd2jd, mjd2t.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-01
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/Aerospace_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f_DD    - (1×1 double) fraction of day [d]
%
% -------
% OUTPUT:
% -------
%   hh      - (1×1 double) hours [h]
%   mm      - (1×1 double) minutes [m]
%   ss      - (1×1 double) seconds [s]
%
%==========================================================================
function [hh,mm,ss] = f2hms(f_DD)
    
    % hours [h]
    hh = floor(24*f_DD);
    
    % minutes [m]
    mm = floor(60*(24*f_DD-hh));
    
    % seconds [s]
    ss = 3600*(24*f_DD-hh-(mm/60));
    
end