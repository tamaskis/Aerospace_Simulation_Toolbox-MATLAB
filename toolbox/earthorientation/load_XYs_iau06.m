%==========================================================================
%
% load_XYs_iau06  Loads data needed for calculating the $X$, $Y$, and $s$
% terms for the precession-nutation matrix (IAU2006/2000, CIO based).
%
%   XYs_iau06 = load_XYs_iau06
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
%--------------------------------------------------------------------------
%
% -------
% OUTPUT:
% -------
%   XYs_iau06   - (1×1 struct) data for calculating X, Y, and s
%       • ax    - (1600×1 double) ax coefficients for X [rad]
%       • ay    - (1275×1 double) ay coefficients for Y [rad]
%       • as    - (66×1 double) ay coefficients for s [rad]
%       • bx    - (1600×1 double) bx coefficients for X [rad]
%       • by    - (1275×1 double) by coefficients for Y [rad]
%       • bs    - (66×1 double) by coefficients for s [rad]
%       • M     - (1600×14 double) fundamental argument coefficients for X
%       • N     - (1275×14 double) fundamental argument coefficients for Y
%       • O     - (66×14 double) fundamental argument coefficients for s
%
%==========================================================================
function XYs_iau06 = load_XYs_iau06
    XYs_iau06 = struct2array(load('XYs_iau06.mat'));
end