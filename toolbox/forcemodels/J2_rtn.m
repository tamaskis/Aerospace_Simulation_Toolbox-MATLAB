%==========================================================================
%
% J2_rtn  Perturbing gravitational acceleration due to J2 resolved in the 
% RTN frame.
%
%   f_J2_rtn = J2_rtn(r,i,u)
%
% See also gravity, J2_ecef, two_body.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] Curtis, "Orbital Mechanics for Engineering Students", 3rd. Ed.,
%       Eq. (12.88) (p. 685)
%   [2] D'Amico, "Earth's Gravity, Atmospheric Drag, Sun and Moon 
%       Perturbations", AA 279A Lecture 11 Slides (p. 4)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r           - (1×1 double) distance between center of Earth and 
%                 satellite [m]
%   i           - (1×1 double) inclination [rad]
%   u           - (1×1 double) argument of latitude [rad]
%
% -------
% OUTPUT:
% -------
%   f_J2_rtn    - (3×1 double) perturbing gravitational acceleration due to
%                 J2 resolved in the RTN frame [m/s^2]
%
%
%
%==========================================================================
function f_J2_rtn = J2_rtn(r,i,u)

    % Earth parameters
    mu = MU_EARTH;      % gravitational parameter [m^3/s^2]
    R = R_EARTH;        % mean equatorial radius [m]
    J2 = J2_EARTH;      % 2nd degree zonal potential coefficient

    % constant [m/s^2]
    k = -(3*J2*mu*R^2)/(2*r^4);

    % perturbing gravitational acceleration due to J2 resolved in the RTN
    % frame [m/s^2]
    f_J2_rtn = k*[1-3*sin(i)^2*sin(u)^2;
                  sin(i)^2*sin(u)*cos(u);
                  sin(i)*cos*(i)*sin(u)];

end