%==========================================================================
%
% eul2dcm313  3-1-3 Euler angles to direction cosine matrix (DCM).
%
%   A = eul2dcm313(phi,theta,psi)
%
% Copyright (c) 2021 Tamas Kis
% Last Update: 2021-05-31
%
%--------------------------------------------------------------------------
%
% -------
% INPUTS:
% -------
%   phi     (1x1) [rad] 3-1-3 Euler angle
%   theta   (1x1) [rad] 3-1-3 Euler angle
%   psi     (1x1) [rad] 3-1-3 Euler angle
%
% --------
% OUTPUTS:
% --------
%   A       (3x3) direction cosine matrix
%
%==========================================================================
function A = eul2dcm313(phi,theta,psi)

    % precomputes trigonometric functions for speed
    sp = sin(psi);
    cp = cos(psi);
    so = sin(theta);
    co = cos(theta);
    sf = sin(phi);
    cf = cos(phi);
     
    % defines direction cosine matrix
    A = [ cp*cf-sp*co*sf    cp*sf+sp*co*cf   sp*so;
         -sp*cf-cp*co*sf   -sp*sf+cp*co*cf   cp*so;
          so*sf            -so*cf            co];
 
end