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
%   r0_ecef     - (1×1 double) origin of ENU frame resolved in ECEF frame
%
% -------
% OUTPUT:
% -------
%   R_enu2ecef  - (3×3 double) rotation matrix (ENU --> ECEF)
%
% -----
% NOTE:
% -----
%   --> r_ecef and r0_ecef can be input in any units, but they MUST be
%       consistent.
%
%==========================================================================
function R_enu2ecef = enu2ecef_matrix(r0_ecef)
    
    % geodetic latitude and longitude of ENU frame's origin [°]
    [lat0,lon0] = ecef2geod(r0_ecef);
    
    % convert geodetic latitude and longitude to radians
    lat0 = deg2rad(lat0);
    lon0 = deg2rad(lon0);
    
    % rotation matrix (ENU --> ECEF)
    R_enu2ecef = rot3(-lon0-pi/2)*rot1(lat0-pi/2);
    
end