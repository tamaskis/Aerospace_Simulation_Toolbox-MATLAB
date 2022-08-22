%==========================================================================
%
% W_EARTH  Earth rotational speed.
%
%   w_earth = W_EARTH
%
% Author: Tamas Kis
% Last Update: 2022-02-05
%
% REFERENCES:
%   [1] Capitaine and Wallace, "Implementation of the IAU2000 definition of
%       UT1 in astronomy",
%       https://www.atnf.csiro.au/iau-comm31/pdf/2009_IAUGA_JD6/JD06_capitaine_wallace.pdf
%   [2] McCarthy and Capitaine, "Practical Consequences of Resolution B1.6,
%       Resolution B1.7, Resolution B1.8", IERS Technical Note No. 29,
%       https://www.iers.org/SharedDocs/Publikationen/EN/IERS/Publications/tn/TechnNote29/tn29_009.pdf?__blob=publicationFile&v=1    
%   [3] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       (p. 1041)
%
%--------------------------------------------------------------------------
%
% -----
% NOTE:
% -----
%   --> From IAU2000.
%
%==========================================================================
function w_earth = W_EARTH
    w_earth = 7.292115146706979e-5; % [rad/s]
end