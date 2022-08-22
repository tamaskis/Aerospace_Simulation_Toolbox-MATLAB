%==========================================================================
%
% dECEFdECI  Partial derivative of ECEF state with respect to ECI state.
%
%   [drdr,drdv,dvdr,dvdv] = dECEFdECI(R_eci2ecef,w_eci)
%
% Author: Tamas Kis
% Last Update: 2022-03-07
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   R_eci2ecef  - (3×3 double) rotation matrix (ECI --> ECEF)
%   w_eci       - (3×1 double) Earth angular velocity resolved in ECI frame
%                 [rad/s]
%
% -------
% OUTPUT:
% -------
%   drdr        - (3×3 double) partial derivative of ECEF position w.r.t.
%                 ECI position [-]
%   drdv        - (3×3 double) partial derivative of ECEF position w.r.t.
%                 ECI velocity [s]
%   dvdr        - (3×3 double) partial derivative of ECEF position w.r.t.
%                 ECI position  [1/s]
%   dvdv        - (3×3 double) partial derivative of ECEF position w.r.t.
%                 ECI velocity [s]
%
%==========================================================================
function [drdr,drdv,dvdr,dvdv] = dECEFdECI(R_eci2ecef,w_eci)
    
    % partial derivative of ECEF position w.r.t. ECI position [-]
    drdr = R_eci2ecef;

    % partial derivative of ECEF position w.r.t. ECI velocity [s]
    drdv = zeros(3,3);

    % cross product matrix for Earth angular velocity [rad/s]
    wx = cross_matrix(w_eci);

    % partial derivative of ECEF velocity w.r.t. ECI position [1/s]
    dvdr = -R_eci2ecef*wx;
    
    % partial derivative of ECEF velocity w.r.t. ECI velocity [-]
    dvdv = R_eci2ecef;
    
end