%==========================================================================
%
% eci2rtn_matrix  Rotation matrix from Earth-centered inertial (ECI) frame
% to Hill/orbital (RTN) frame.
%
%   R_eci2rtn = eci2rtn_matrix(r_eci,v_eci)
%
% See also rtn2eci_matrix.
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
%   R_eci2rtn   - (3×3 double) rotation matrix (ECI --> RTN)
%
% -----
% NOTE:
% -----
%   --> r_eci and v_eci can be input in any units, but they MUST be 
%       consistent.
%
%==========================================================================
function R_eci2rtn = eci2rtn_matrix(r_eci,v_eci)

    % R, T, and N basis vectors resolved in ECI frame
    R_eci = r_eci/inorm(r_eci);
    N_eci = cross(r_eci,v_eci)/inorm(cross(r_eci,v_eci));
    T_eci = cross(N_eci,R_eci);
    
    % rotation matrix from ECI frame to RTN frame
    R_eci2rtn = [R_eci,T_eci,N_eci].';

end