%==========================================================================
%
% rv2omega  Angular velocity of a rotating coordinate frame from position
% and inertial velocity.
%
%   omega_I2R_I = rv2omega(r,v)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-09-24
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
%   r           - (3×1 double) position expressed in frame I
%   v           - (3×1 double) inertial velocity expressed in frame I
%
% -------
% OUTPUT:
% -------
%   omega_I2R_I - (3×1 double) angular velocity of frame R relative to
%                 frame I, expressed in frame I [rad/s]
%
% -----
% NOTE:
% -----
%   • r and v can be input in any units, but they MUST be consistent.
%   • The rotating frame, R, is defined such that the unit vector of r
%     defines the 1st axis, the unit vector of r × v defines the 3rd axis,
%     and the 2nd axis completes the right-handed triad.
%   • The 1st and 2nd axes of the rotating frame, R, define the
%     instantaneous plane of motion in which both r and v lie.
%
%==========================================================================
function omega_I2R_I = rv2omega(r,v)
    omega_I2R_I = cross(r,v)/idot(r,r);
end