%==========================================================================
%
% noise_carrier_phase  Thermal noise associated with a carrier phase
% measurement.
%
%   eps_Phi = noise_carrier_phase(r_rcv_ecef,r_sat_ecef)
%
% Author: Tamas Kis
% Last Update: 2022-03-21
%
% REFERENCES:
%   [1] Giralo, "Precision Navigation of Miniaturized Distributed Space 
%       Systems using GNSS" (pp. 79-80)
%   [2] Kaplan and Hegarty, "Understanding GPS/GNSS: Principles and
%       Applications", 3rd Ed. (pp. 475-476)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_rcv_ecef  - (3×1 double) receiver position resolved in ECEF frame [m]
%   r_sat_ecef  - (3×1 double) GNSS satellite position resolved in ECEF 
%                 frame [m]
%
% -------
% OUTPUT:
% -------
%   eps_Phi - (1×1 double) carrier phase measurement thermal noise [m]
%
%==========================================================================
function eps_Phi = noise_carrier_phase(r_rcv_ecef,r_sat_ecef)
    
    % speed of light [m/s]
    c = C_LIGHT;
    
    % GPS L1 signal frequency [Hz]
    f_L1 = F_L1;
    
    % phase lock loop bandwidth [Hz]
    B_pll = 1.6e13;
    
    % carrier power to noise power ratio [dB.Hz]
    CN0 = ecef2cn0(r_rcv_ecef,r_sat_ecef);

    % converts C/N₀ to Hz
    CN0_Hz = 10^(CN0/10);
    
    % carrier phase measurement thermal noise standard deviation [m]
    sigma_Phi = (c/(2*pi*f_L1))*sqrt(B_pll/CN0_Hz);
    
    % samples carrier phase measurement thermal noise [m]
    eps_Phi = normrnd(0,sigma_Phi);
    
end