%==========================================================================
%
% carrier_phase  GNSS carrier phase measurement.
%
%   Phi = carrier_phase(r_rcv_ecef,r_sat_ecef,b_rcv,b_sat,t,N)
%   Phi = carrier_phase(r_rcv_ecef,r_sat_ecef,b_rcv,b_sat,t,N,...
%       iono_delay,noise)
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
%   N           - (1×1 double) integer ambiguity [-]
%   iono_delay  - (1×1 logical) (OPTIONAL) "true" if ionospheric path delay
%                 should be included, "false" otherwise (defaults to 
%                 "false")
%   noise       - (1×1 logical) (OPTIONAL) "true" if random noise should be
%                 included, "false" otherwise (defaults to false)
%
% -------
% OUTPUT:
% -------
%   Phi         - (1×1 double) carrier phase measurement [m]
%
%==========================================================================
function Phi = carrier_phase(r_rcv_ecef,r_sat_ecef,b_rcv,b_sat,t,N,...
    iono_delay,noise)

    % defaults "iono_delay" to "false" if not input
    if (nargin < 7) || isempty(iono_delay)
        iono_delay = false;
    end

    % defaults "noise" to "false" if not input
    if (nargin < 8) || isempty(noise)
        noise = false;
    end
    
    % L1 signal wavelength [m]
    lambda = C_LIGHT/F_L1;
    
    % ionospheric path delay [m]
    if iono_delay
        [alpha,beta] = klobuchar_coeffs(57754);
        I = ionosphere(r_rcv_ecef,r_sat_ecef,alpha,beta,t);
    else
        I = 0;
    end
    
    % measurement noise [m]
    if noise
        eps_Phi = noise_carrier_phase(r_rcv_ecef,r_sat_ecef);
    else
        eps_Phi = 0;
    end
    
    % carrier phase measurement [m]
    Phi = inorm(r_rcv_ecef-r_sat_ecef)+(b_rcv-b_sat)-I+lambda*N+eps_Phi;
    
end