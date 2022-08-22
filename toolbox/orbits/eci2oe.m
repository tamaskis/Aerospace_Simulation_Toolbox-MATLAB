%==========================================================================
%
% eci2oe  Keplerian orbital elements from ECI position and velocity.
%
%   [a,e,i,Om,w,nu] = eci2oe(r,v)
%   [a,e,i,Om,w,nu,ang] = eci2oe(r,v)
%
% See also oe2eci.
%
% Author: Tamas Kis
% Last Update: 2022-02-16
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r       - (3×1 double) position in resolved ECI frame [m]
%   v       - (3×1 double) inertial velocity resolved in ECI frames [m/s]
%
% -------
% OUTPUT:
% -------
%   a       - (1×1 double) semi-major axis [m]
%   e       - (1×1 double) eccentricity [-]
%   i       - (1×1 double) inclination [rad]
%   Om      - (1×1 double) right ascension of the ascending node [rad]
%   w       - (1×1 double) argument of periapsis [rad]
%   nu      - (1×1 double) true anomaly [rad]
%   ang     - (OPTIONAL) (1×1 double) extra angle for special cases [rad]:
%               --> Pi    true lon. of periapsis (non-circular, equatorial)
%               --> u     true argument of latitude (circular, inclined)
%               --> l     true longitude (circular, equatorial)
%
%==========================================================================
function [a,e,i,Om,w,nu,ang] = eci2oe(r,v)
    
    % Earth gravitational parameter [m^3/s^2]
    mu = MU_EARTH;
    
    % specific angular momentum [m^2/s]
    h = cross(r,v);
    
    % stores vector magnitudes
    r_mag = inorm(r);
    v_mag = inorm(v);
    h_mag = inorm(h);
    
    % stores dot product between position and velocity [m^2/s]
    r_dot_v = idot(r,v);
        
    % eccentricity vector and its magnitude
    e_vec = (v_mag^2/mu-1/r_mag)*r-(r_dot_v/mu)*v;
    e = inorm(e_vec);
    
    % node vector and its magnitude
    n = cross([0;0;1],h);
    n_mag = inorm(n);
    
    % stores components of vectors needed later
    eI = e_vec(1);
    eJ = e_vec(2);
    eK = e_vec(3);
    hK = h(3);
    nI = n(1);
    nJ = n(2);
    rI = r(1);
    rJ = r(2);
    rK = r(3);
    
    % specific mechanical energy [m^2/s^2]
    Em = v_mag^2/2-mu/r_mag;

    % semi-major axis [m]
    if e == 1
        a = inf;
    else
        a = -mu/(2*Em);
    end

    % inclination [rad]
    i = acos(hK/h_mag);

    % right ascension of the ascending node [rad]
    if nJ >= 0
        Om = acos(nI/n_mag);
    else
        Om = 2*pi-acos(nI/n_mag);
    end

    % argument of periapsis [rad]
    if eK >= 0
        w = acos(idot(n,e_vec)/(n_mag*e));
    else
        w = 2*pi-acos(idot(n,e_vec)/(n_mag*e));
    end

    % true anomaly [rad]
    if r_dot_v >= 0
        nu = acos(idot(e_vec,r)/(e*r_mag));
    else
        nu = 2*pi-acos(idot(e_vec,r)/(e*r_mag));
    end
    
    % initializes angle for special cases [rad]
    ang = 0;
    
    % non-circular + equatorial orbits (true longitude of periapsis, Pi)
    % [rad]
    if (i == 0) && (e ~= 0)
        if eJ >= 0
            ang = acos(eI/e);
        else
            ang = 2*pi-acos(eI/e);
        end
    end
    
    % circular + inclined orbits (true argument of latitude, u) [rad]
    if (i ~= 0) && (e == 0)
        if rK >= 0
            ang = acos(idot(n,r)/(n_mag*r_mag));
        else
            ang = 2*pi-acos(idot(n,r)/(n_mag*r_mag));
        end
    end
    
    % circular + equatorial orbits (true longitude, l) [rad]
    if (i == 0) && (e == 0)
        if rJ >= 0
            ang = acos(rI/r_mag);
        else
            ang = 2*pi-acos(rI/r_mag);
        end
    end
    
end