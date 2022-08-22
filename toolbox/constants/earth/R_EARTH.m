%==========================================================================
%
% R_EARTH  Earth mean equatorial radius (i.e. semi-major axis).
%
%   R_earth = R_EARTH
%
% Author: Tamas Kis
% Last Update: 2022-02-05
%
% REFERENCES:
%   [1] GGM05S.ICGEM.gz (http://download.csr.utexas.edu/pub/grace/GGM05/)
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       (p. 1041)
%
%--------------------------------------------------------------------------
%
% -----
% NOTE:
% -----
%   --> From GGM05s gravity model.
%
%==========================================================================
function R_earth = R_EARTH
    R_earth = 6378136.3;    % [m]
end