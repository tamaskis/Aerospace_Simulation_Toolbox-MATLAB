%==========================================================================
%
% rot_pcpf2enu  Passive rotation matrix from the planet-centered
% planet-fixed (PCPF) frame to an east-north-up frame.
%
%   R_pcpf2enu = rot_pcpf2enu(lat0,lon0)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2024-01-10
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/Aerospace_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   lat0        - (1×1 double) reference point planetodetic latitude, φ₀
%                 [°]
%   lon0        - (1×1 double) reference point planetodetic longitude, λ₀
%                 [°]
%
% -------
% OUTPUT:
% -------
%   R_pcpf2enu  - (3×3 double) passive rotation matrix from PCPF frame to
%                 ENU frame
%
%==========================================================================
function R_pcpf2enu = rot_pcpf2enu(lat0,lon0)
    
    % convert planetodetic latitude and longitude to radians
    lat0 = deg2rad(lat0);
    lon0 = deg2rad(lon0);
    
    % precompute trigonometric functions
    s1 = sin(lat0);
    c1 = cos(lat0);
    s2 = sin(lon0);
    c2 = cos(lon0);
    
    % passive rotation matrix from PCPF frame to ENU frame
    R_pcpf2enu = [-s2      c2      0;
                  -s1*c2  -s1*s2   c1;
                   c1*c2   c1*s2   s1];
    
end