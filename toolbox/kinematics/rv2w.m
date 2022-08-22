%==========================================================================
%
% rv2w  Frame angular velocity from position and velocity.
%
%   w = rv2w(r,v)
%
% Author: Tamas Kis
% Last Update: 2022-02-27
%
% REFERENCES:
%   [1] https://en.wikipedia.org/wiki/Angular_velocity
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r       - (3×1 double) position resolved in frame E
%   v       - (3×1 double) velocity relative to AND resolved in frame E
%
% -------
% OUTPUT:
% -------
%   w       - (3×1 double) angular velocity of frame F relative to AND
%             resolved in frame E [rad/s]
%
% -----
% NOTE:
% -----
%   --> Frame E is the stationary frame (i.e. the coordinate frame that the
%       velocity is measured relative to).
%   --> Frame F is a frame whose orientation is fixed with respect to the
%       position vector.
%   --> r and v can be input in any units, but they MUST be consistent.
%
%==========================================================================
function w = rv2w(r,v)
    w = cross(r,v)/idot(r,r);
end