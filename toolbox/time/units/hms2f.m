%==========================================================================
%
% hms2f  Fraction of day from hours, minutes, and seconds.
%
%   f_DD = hms2f(hh,mm,ss)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, jd2mjd, jd2t, mjd2cal, mjd2f,
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
%   hh      - (1×1 double) hours [h]
%   mm      - (1×1 double) minutes [m]
%   ss      - (1×1 double) seconds [s]
%
% -------
% OUTPUT:
% -------
%   f_DD    - (1×1 double) fraction of day [d]
%
%==========================================================================
function f_DD = hms2f(hh,mm,ss)
    f_DD = (hh/24)+(mm/1440)+(ss/86400);
end