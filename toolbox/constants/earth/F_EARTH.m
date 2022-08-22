%==========================================================================
%
% F_EARTH  Earth flattening.
%
%   f = F_EARTH
%
% Author: Tamas Kis
% Last Update: 2022-02-05
%
% REFERENCES:
%   [1] Department of Defense World Geodetic System 1984,
%       https://apps.dtic.mil/sti/pdfs/AD1000581.pdf
%
%--------------------------------------------------------------------------
%
% -----
% NOTE:
% -----
%   --> From WGS 84.
%
%==========================================================================
function f = F_EARTH
    f = 1/298.257223563;
end