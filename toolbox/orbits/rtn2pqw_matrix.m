%==========================================================================
%
% rtn2pqw_matrix  Rotation matrix from Hill/orbital (RTN) frame to 
% perifocal (PQW) frame.
%
%   R_rtn2pqw = rtn2pqw_matrix(nu)
%
% See also pqw2rtn_matrix.
%
% Author: Tamas Kis
% Last Update: 2022-02-16
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (p. 168)
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
%   R_rtn2pqw   - (3×3 double) rotation matrix (RTN --> PQW)
%
%==========================================================================
function R_rtn2pqw = rtn2pqw_matrix(nu)
    R_rtn2pqw = rot3(-nu);
end