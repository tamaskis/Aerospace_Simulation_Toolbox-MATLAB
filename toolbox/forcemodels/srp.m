%==========================================================================
%
% srp  Perturbing acceleration due to solar radiation pressure.
%
%   f_srp = srp(r,r_sun,CR,Asrp,m)
%
% Author: Tamas Kis
% Last Update: 2022-02-27
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", Eq. (3.75) (p. 79)
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (8-44) (p. 581)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r       - (3×1 double) satellite position [m]
%   r_sun   - (3×1 double) Sun position [m]
%   CR      - (1×1 double) coefficient of reflectivity
%   Asrp    - (1×1 double) SRP reference area [m^2]
%   m       - (1×1 double) mass [kg]
%
% -------
% OUTPUT:
% -------
%   f_srp   - (3×1 double) perturbing acceleration due to solar radiation
%             pressure [m/s^2]
%
% -----
% NOTE:
% -----
%   --> "r" and "r_sun" must be resolved in the same coordinate frame.
%
%==========================================================================
function f_srp = srp(r,r_sun,CR,Asrp,m)
    
    % determines if satellite is in eclipse
    in_eclipse = eclipse(r,r_sun);

    % returns 0 if satellite is in eclipse
    if in_eclipse
        f_srp = [0;0;0];
        return;
    end

    % solar radiation pressure [N/m^2]
    P_srp = P_SRP;
    
    % position of satellite with respect to Sun [m]
    r_rel = r-r_sun;
    
    % perturbing acceleration due to solar radiation pressure [m/s^2]
    f_srp = (P_srp*CR*Asrp/m)*(r_rel/inorm(r_rel));
    
end