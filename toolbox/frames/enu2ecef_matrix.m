%==========================================================================
%
% enu2ecef_matrix  Rotation matrix from East, North, Up (ENU) frame to 
% Earth-centered Earth-fixed (ECEF) frame.
%
%   R_enu2ecef = enu2ecef(r0_ecef)
%
% See also ecef2enu_matrix.
%
% Author: Tamas Kis
% Last Update: 2022-02-26
%
% REFERENCES:
%   [1] https://gssc.esa.int/navipedia/index.php/Transformations_between_ECEF_and_ENU_coordinates
%   [2] D'Amico, "Earth Ellipsoid, Geoid, Terrain, Relative Motion w.r.t. 
%       Ground Station", AA 279A Lecture 7-8 Slides (pp. 14-16)
%   [3] Montenbruck and Gill, "Satellite Orbits" (pp. 36-38)
%   [4] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 262-263)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   lat0        - (1×1 double) planetodetic latitude of ENU frame origin
%                 [°]
%   lon0        - (1×1 double) planetodetic longitude of ENU frame origin
%                 [°]
%
% -------
% OUTPUT:
% -------
%   R_enu2ecef  - (3×3 double) rotation matrix from ENU frame to PCPF frame
%
%==========================================================================
function R_enu2ecef = enu2ecef_matrix(lat0,lon0)
    R_enu2ecef = rot3(-lon0-pi/2)*rot1(lat0-pi/2);
end