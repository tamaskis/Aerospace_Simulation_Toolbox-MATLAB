%==========================================================================
%
% graphic  Group and phase ionospheric correction (GRAPHIC) measurement.
%
%   rho_gr = graphic(rho,Phi)
%
% Author: Tamas Kis
% Last Update: 2022-03-19
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   rho     - (1×1 double) pseudorange measurement [m]
%   Phi     - (1×1 double) carrier phase measurement [m]
%
% -------
% OUTPUT:
% -------
%   rho_gr  - (1×1 double) GRAPHIC measurement [m]
%
%==========================================================================
function rho_gr = graphic(rho,Phi)
    rho_gr = (rho+Phi)/2;
end