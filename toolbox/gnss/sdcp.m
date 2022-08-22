%==========================================================================
%
% sdcp  GNSS single-difference carrier phase (SDCP) measurement.
%
%   rho_sdcp_uv = sdcp(phi_u,phi_v)
%
% Author: Tamas Kis
% Last Update: 2022-03-16
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   phi_u       - (1×1 double) receiver "u" carrier phase measurement [m]
%   phi_v       - (1×1 double) receiver "v" carrier phase measurement [m]
%
% -------
% OUTPUT:
% -------
%   rho_sdcp    - (1×1 double) SDCP measurement for receiver pair (u,v) [m]
%
%==========================================================================
function rho_sdcp_uv = sdcp(phi_u,phi_v)
    rho_sdcp_uv = phi_u-phi_v;
end