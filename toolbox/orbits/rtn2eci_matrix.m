%==========================================================================
%
% rtn2eci_matrix  Rotation matrix from Hill/orbital (RTN) frame to Earth-
% centered inertial (ECI) frame.
%
%   R_rtn2eci = rtn2eci_matrix(r_eci,v_eci)
%
% See also eci2rtn_matrix.
%
% Author: Tamas Kis
% Last Update: 2022-02-16
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 163-164)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_eci       - (3×1 double) position resolved in ECI frame
%   v_eci       - (3×1 double) inertial velocity resolved in ECI frame
%
% -------
% OUTPUT:
% -------
%   R_rtn2eci   - (3×3 double) rotation matrix (RTN --> ECI)
%
% -----
% NOTE:
% -----
%   --> r_eci and v_eci can be input in any units, but they MUST be 
%       consistent.
%
%==========================================================================
function R_rtn2eci = rtn2eci_matrix(r,v)

    % R, T, and N basis vectors resolved in ECI frame
    R_eci = r/inorm(r);
    N_eci = cross(r,v)/inorm(cross(r,v));
    T_eci = cross(N_eci,R_eci);
    
    % rotation matrix from RTN frame to ECI frame
    R_rtn2eci = [R_eci,T_eci,N_eci];

end