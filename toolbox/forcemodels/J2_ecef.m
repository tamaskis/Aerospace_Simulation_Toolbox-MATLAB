%==========================================================================
%
% J2_ecef  Perturbing gravitational acceleration due to J2 (resolved in the
% ECEF frame).
%
%   f_J2_ecef = J2_ecef(r_ecef)
%
% See also gravity, J2_rtn, two_body.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] Curtis, "Orbital Mechanics for Engineering Students", 3rd. Ed.,
%       Eq. (12.30) (p. 664)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef      - (3×1 double) position resolved in ECEF frame [m]
%
% -------
% OUTPUT:
% -------
%   f_J2_ecef   - (3×1 double) perturbing gravitational acceleration due to
%                 J2 resolved in the ECEF frame [m/s^2]
%
%==========================================================================
function f_J2_ecef = J2_ecef(r_ecef)

    % Earth parameters
    mu = MU_EARTH;  % gravitational parameter [m^3/s^2]
    R = R_EARTH;    % mean equatorial radius [m]
    J2 = J2_EARTH;  % 2nd degree zonal potential coefficient
    
    % extracts position components
    rX = r_ecef(1);
    rY = r_ecef(2);
    rZ = r_ecef(3);

    % distance from center of the Earth [m]
    r = sqrt(rX^2+rY^2+rZ^2);

    % constant [m/s^2]
    k = (3*J2*mu*R^2)/(2*r^4);

    % perturbing gravitational acceleration due to J2 resolved in the ECEF
    % frame [m/s^2]
    f_J2_ecef = k*[(rX/r)*(((5*rZ^2)/r^2)-1);
                   (rY/r)*(((5*rZ^2)/r^2)-1);
                   (rZ/r)*(((5*rZ^2)/r^2)-3)];

end