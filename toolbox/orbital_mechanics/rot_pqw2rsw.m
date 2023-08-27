%==========================================================================
%
% rot_pqw2rsw  Passive rotation matrix from the perifocal (PQW) frame to
% the RSW frame.
%
%   R_pqw2rsw = rot_pqw2rsw(nu)
%
% See also rot_rsw2pqw.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-08-27
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
%   nu          - (1×1 double) true anomaly [rad]
%
% -------
% OUTPUT:
% -------
%   R_pqw2rsw   - (3×3 double) passive rotation matrix from the perifocal
%                 (PQW) frame to the RSW frame
%
%==========================================================================
function R_pqw2rsw = rot_pqw2rsw(nu)
    R_pqw2rsw = rot3(nu);
end