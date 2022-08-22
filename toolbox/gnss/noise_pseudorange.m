%==========================================================================
%
% noise_pseudorange  Thermal noise associated with a pseudorange
% measurement.
%
%   eps_rho = noise_pseudorange(r_rcv_ecef,r_sat_ecef)
%
% Author: Tamas Kis
% Last Update: 2022-03-21
%
% REFERENCES:
%   [1] Giralo, "Precision Navigation of Miniaturized Distributed Space 
%       Systems using GNSS" (p. 79)
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
%   eps_rho - (1×1 double) pseudorange measurement thermal noise [m]
%
%==========================================================================
function eps_rho = noise_pseudorange(r_rcv_ecef,r_sat_ecef)
    
    % speed of light [m/s]
    c = C_LIGHT;
    
    % delay lock loop bandwidth [Hz]
    B_dll = 0.01;
    
    % carrier power to noise power ratio [dB.Hz]
    CN0 = ecef2cn0(r_rcv_ecef,r_sat_ecef);

    % converts C/N₀ to Hz
    CN0_Hz = 10^(CN0/10);

    % pseudorange measurement thermal noise standard deviation [m]
    sigma_rho = (c/(1.023e6))*sqrt(B_dll/CN0_Hz);

    % samples pseudorange measurement thermal noise [m]
    eps_rho = normrnd(0,sigma_rho);
    
end