%==========================================================================
%
% drhodr_nrlmsise00  Partial derivative of atmospheric mass density with 
% respect to position resolved in ECI frame (NRLMSISE-00).
%
%   drhodr = drhodr_nrlmsise00(r_ecef,MJD_UT1,F107_avg,F107,ap_array,...
%       nrlm_data,R_eci2ecef)
%
% Author: Tamas Kis
% Last Update: 2022-03-22
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef      - (3×1 double) position resolved in ECEF frame [m]
%   MJD_UT1     - (1×1 double) UT1 (Universal Time 1) [MJD]
%   F107_avg    - (1×1 double) centered 81-day average of F10.7 (1-day lag)
%                 [SFU]
%   F107        - (1×1 double) daily 10.7 cm solar flux (1-day lag) [SFU]
%   ap_array    - (1×1 double) array of planetary amplitude values [γ]
%                   1. daily planetary amplitude (current day - no lag) [γ]
%                   2. planetary amplitude (current time) [γ]
%                   3. planetary amplitude (3 hours before) [γ]
%                   4. planetary amplitude (6 hours before) [γ]
%                   5. planetary amplitude (9 hours before) [γ]
%                   6. planetary amplitude (avg. of 12-33 hours before) [γ]
%                   7. planetary amplitude (avg. of 36-57 hours before) [γ]
%   nrlm_data   - (1×1 struct) data for NRLMSISE-00 atmospheric model
%       • pt    (1×150 double)
%       • pd    (9×150 double)
%       • ps    (1×150 double)
%       • pdl   (2×25 double)
%       • ptm   (1×10 double)
%       • pdm   (8×10 double)
%       • ptl   (4×100 double)
%       • pma   (10×100 double)
%       • sam   (1×100 double)
%       • pavgm (1×10 double)
%   R_eci2ecef  - (3×3 double) rotation matrix (ECI --> ECEF)
%
% -------
% OUTPUT:
% -------
%   drhodr      - (1×3 double) partial derivative of atmospheric mass
%                 density w.r.t. position, resolved in ECI frame [kg/m^4]
%
%==========================================================================
function drhodr = drhodr_nrlmsise00(r_ecef,MJD_UT1,F107_avg,F107,...
    ap_array,nrlm_data,R_eci2ecef)

    % partial derivative of atmospheric mass density w.r.t. position,
    % resolved in ECEF frame [kg/m^4]
    drhodr_ecef = ijacobian(@(r_ecef)nrlmsise00(r_ecef,MJD_UT1,F107_avg,...
        F107,ap_array,nrlm_data),r_ecef);

    % partial derivative of atmospheric mass density w.r.t. position,
    % resolved in ECI frame [kg/m^4]
    drhodr = drhodr_ecef*R_eci2ecef;

end