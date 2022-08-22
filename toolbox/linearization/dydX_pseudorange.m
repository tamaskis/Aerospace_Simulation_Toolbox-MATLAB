%==========================================================================
%
% dydX_pseudorange  Partial derivatives of pseudorange measurement with 
% respect to position and inertial velocity resolved in the ECI frame.
%
%   [drhodr,drhodv] = dydX_pseudorange(r_rcv_eci,r_sat_eci)
%
% Author: Tamas Kis
% Last Update: 2022-03-19
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_rcv_eci   - (3×1 double) receiver position resolved in ECI frame [m]
%   r_sat_ecef  - (3×l double) GNSS satellite positions resolved in ECI
%                 frame [m]
%
% -------
% OUTPUT:
% -------
%   drhodr      - (l×3 double) partial derivative of pseudoranges w.r.t.
%                 position resolved in ECI frame [s/s]
%   drhodv      - (l×3 double) partial derivative of pseudoranges w.r.t.
%                 inertial velocity resolved in ECI frame [s]
%
%==========================================================================
function [drhodr,drhodv] = dydX_pseudorange(r_rcv_eci,r_sat_eci)
    
    % determines number of GNSS satellites
    l = size(r_sat_eci,2);
    
    % partial derivative of pseudoranges w.r.t. position resolved in ECI
    % frame [-]
    drhodr = zeros(l,3);
    for k = 1:l
        drhodr(k,:) = -((r_sat_eci(:,k)-r_rcv_eci)/inorm(r_sat_eci(:,k)-...
            r_rcv_eci)).';
    end
    
    % partial derivative of pseudorange w.r.t. inertial velocity resolved 
    % in ECI frame [s]
    drhodv = zeros(l,3);
    
end