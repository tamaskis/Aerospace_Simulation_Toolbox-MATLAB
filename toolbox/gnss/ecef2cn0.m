%==========================================================================
%
% ecef2cn0  Carrier power to noise power ratio from ECEF positions of GNSS
% receiver and GNSS satellite.
%
%   CN0 = ecef2cn0(r_rcv_ecef,r_sat_ecef)
%
% Author: Tamas Kis
% Last Update: 2022-03-21
%
% REFERENCES:
%   [1] Kubo et al., "GNSS Multipath Detection Using Continuous Time-Series 
%       C/N0"
%   [2] de Bakker et al., "Real-time multi-GNSS single-frequency precise 
%       point positioning"
%   [3] Misra and Enge, "Global Positioning System: Signals, Measurements,
%       and Performance", 2nd Ed. (p. 409)
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
%   CN0         - (1×1 double) signal power to noise power ratio, C/N₀ 
%                 [dB-Hz]
%
%==========================================================================
function CN0 = ecef2cn0(r_rcv_ecef,r_sat_ecef)
    
    % position of GNSS satellite relative to receiver, resolved in ENU
    % frame of receiver [m]
    r_rel_ENU = ecef2enu(r_sat_ecef,r_rcv_ecef);
    
    % elevation angle of GNSS satellite [°]
    [~,El] = enu2aer(r_rel_ENU);
    
    % carrier power to noise power ratio [dB-Hz]
    CN0 = 25.0092+(0.87929*El)-(0.01646*El^2)+(0.00014385*El^3)-...
        ((4.6764e-7)*El^4);
    
end