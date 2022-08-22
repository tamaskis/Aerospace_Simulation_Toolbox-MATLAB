%==========================================================================
%
% MU_EARTH  Earth gravitational parameter.
%
%   mu_earth = MU_EARTH
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
function mu_earth = MU_EARTH
    mu_earth = 3.986004415e14;  % [m^3/s^2]
end