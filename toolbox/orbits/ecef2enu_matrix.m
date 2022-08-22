%==========================================================================
%
% ecef2enu_matrix  Rotation matrix from Earth-centered Earth-fixed (ECEF) 
% frame to East, North, Up (ENU) frame.
%
%   R_ecef2enu = ecef2enu(r0_ecef)
%
% See also enu2ecef_matrix.
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
%   R_ecef2enu  - (3×3 double) rotation matrix (ECEF --> ENU)
%
%==========================================================================
function R_ecef2enu = ecef2enu_matrix(r0_ecef)
    
    % geodetic latitude and longitude of ENU frame's origin [°]
    [lat0,lon0] = ecef2geod(r0_ecef);
    
    % convert geodetic latitude and longitude to radians
    lat0 = deg2rad(lat0);
    lon0 = deg2rad(lon0);
    
    % rotation matrix (ECEF --> ENU)
    R_ecef2enu = rot1(pi/2-lat0)*rot3(pi/2+lon0);
    
end