%==========================================================================
%
% pseudorange  GNSS pseudorange measurement.
%
%   rho = pseudorange(r_rcv_ecef,r_sat_ecef,b_rcv,b_sat,t,iono_delay)
%   rho = pseudorange(r_rcv_ecef,r_sat_ecef,b_rcv,b_sat,t,iono_delay,noise)
%
% Author: Tamas Kis
% Last Update: 2022-03-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_rcv_ecef  - (3×1 double) receiver position resolved in ECEF frame [m]
%   r_sat_ecef  - (3×1 double) GPS satellite position resolved in ECEF 
%                 frame [m]
%   b_rcv       - (1×1 double) receiver clock bias [m]
%   b_sat       - (1×1 double) GPS satellite clock bias [m]
%   t           - (1×1 double) GPS time (seconds of week) [s]
%   iono_delay  - (1×1 logical) (OPTIONAL) "true" if ionospheric path delay
%                 should be included, "false" otherwise (defaults to 
%                 "false")
%   noise       - (1×1 logical) (OPTIONAL) "true" if random noise should be
%                 included, "false" otherwise (defaults to false)
%
% -------
% OUTPUT:
% -------
%   rho         - (1×1 double) pseudorange measurement [m]
%
%==========================================================================
function rho = pseudorange(r_rcv_ecef,r_sat_ecef,b_rcv,b_sat,t,...
    iono_delay,noise)
    
    % defaults "iono_delay" to "false" if not input
    if (nargin < 6) || isempty(iono_delay)
        iono_delay = false;
    end

    % defaults "noise" to "false" if not input
    if (nargin < 7) || isempty(noise)
        noise = false;
    end
    
    % ionospheric path delay [m]
    if iono_delay
        [alpha,beta] = klobuchar_coeffs(57754);
        I = ionosphere(r_rcv_ecef,r_sat_ecef,alpha,beta,t);
    else
        I = 0;
    end
    
    % measurement noise (0 mean, 0.5 m std. dev.) [m]
    if noise
        eps_rho = noise_pseudorange(r_rcv_ecef,r_sat_ecef);
    else
        eps_rho = 0;
    end
    
    % pseudorange measurement [m]
    rho = inorm(r_rcv_ecef-r_sat_ecef)+(b_rcv-b_sat)+I+eps_rho;
    
end