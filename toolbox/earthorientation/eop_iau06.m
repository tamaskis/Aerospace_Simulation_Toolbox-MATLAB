%==========================================================================
%
% eop_iau06  Earth orientation parameters (IAU2006/2000, CIO based).
%
%   [xp,yp,dX,dY,LOD] = eop_iau06(MJD_UT1,eop)
%
% See also load_eop.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UT1 - (1×1 double) UT1 (Universal Time 1) [MJD]
%   eop     - (N×6 double) array storing Earth orientation parameters
%               --> Column 1: MJD - modified Julian date [MJD]
%               --> Column 2: xp  - polar coordinate of the CIP ['']
%               --> Column 3: yp  - polar coordinate of the CIP ['']
%               --> Column 4: dX  - correction term for X [mas]
%               --> Column 5: dY  - correction term for Y [mas]
%               --> Column 6: LOD - length of day [ms]
%
% -------
% OUTPUT:
% -------
%   xp      - (1×1 double) polar coordinate of the CIP ['']
%   yp      - (1×1 double) polar coordinate of the CIP ['']
%   dX      - (1×1 double) correction term for X [mas]
%   dY      - (1×1 double) correction term for Y [mas]
%   LOD     - (1×1 double) length of day [ms]
%
%==========================================================================
function [xp,yp,dX,dY,LOD] = eop_iau06(MJD_UT1,eop)
    
    % index for data at current time
    i = interval_search(eop(:,1),MJD_UT1,false);

    % extract Earth orientation parameters at current time
    xp = eop(i,2);
    yp = eop(i,3);
    dX = eop(i,4);
    dY = eop(i,5);
    LOD = eop(i,6);
    
end