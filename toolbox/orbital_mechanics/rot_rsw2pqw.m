%==========================================================================
%
% rot_rsw2pqw  Passive rotation matrix from the RSW frame to the perifocal
% (PQW) frame to the RSW frame.
%
%   R_rsw2pqw = rot_rsw2pqw(nu)
%
% See also rot_pqw2rsw.
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
%   R_rsw2pqw   - (3×3 double) passive rotation matrix from the RSW frame
%                 to the perifocal (PQW) frame
%
%==========================================================================
function R_rsw2pqw = rot_rsw2pqw(nu)
    R_rsw2pqw = rot3(-nu);
end