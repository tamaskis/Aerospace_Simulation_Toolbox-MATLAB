%==========================================================================
%
% eci2ecef_matrix_approx  Rotation matrix from Earth-centered inertial 
% (ECI) frame to Earth-centered Earth-fixed (ECEF) frame (approximate).
%
%   R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1)
%   R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1,'Linear')
%   R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1,'IAU2006/2000')
%   R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1,'Vallado')
%
% See also ecef2eci_matrix_approx, iau06.
%
% Author: Tamas Kis
% Last Update: 2022-02-26
%
% REFERENCES:
%   [1] D'Amico, "Earth Rotation and Time Systems", AA 279A Lecture 6 
%       Slides (p. 3)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UT1     - (1×1 double) UT1 (Universal Time 1) [rad]
%   gmst_model  - (char) (OPTIONAL) model used for GMST (defaults to 
%                 'Linear'):
%                   --> 'Linear' uses gmst_linear
%                   --> 'IAU2006/2000' uses gmst_iau06
%                   --> 'Vallado' uses gmst_vallado
%
% -------
% OUTPUT:
% -------
%   R_eci2ecef  - (3×3 double) rotation matrix (ECI --> ECEF)
%
%==========================================================================
function R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1,gmst_model)
    
    % defaults "gmst_model" to 'Linear' if not input
    if (nargin == 1) || isempty(gmst_model)
        gmst_model = 'Linear';
    end

    % Greenwich mean sidereal time [rad]
    if strcmpi(gmst_model,'Linear')
        GMST = gmst_linear(MJD_UT1);
    elseif strcmpi(gmst_model,'IAU2006/2000')
        GMST = gmst_iau06(MJD_UT1);
    elseif strcmpi(gmst_model,'Vallado')
        GMST = gmst_vallado(MJD_UT1);
    end
    
    % rotation matrix from ECI frame to ECEF frame
    R_eci2ecef = rot3(GMST);
    
end