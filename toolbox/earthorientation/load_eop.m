%==========================================================================
%
% load_eop  Loads data storing Earth orientation parameters (IAU2006/2000, 
% CIO based).
%
%   eop = load_eop
%   eop = load_eop(MJD_UTC0,duration)
%
% Author: Tamas Kis
% Last Update: 2022-02-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UTC0    - (1×1 double) (OPTIONAL) initial UTC [MJD]
%   duration    - (1×1 double) (OPTIONAL) simulation duration [h]
%
% -------
% OUTPUT:
% -------
%   eop         - (N×6 double) array storing Earth orientation parameters
%                   --> Column 1: MJD - modified Julian date [MJD]
%                   --> Column 2: xp  - polar coordinate of the CIP ['']
%                   --> Column 3: yp  - polar coordinate of the CIP ['']
%                   --> Column 4: dX  - correction term for X [mas]
%                   --> Column 5: dY  - correction term for Y [mas]
%                   --> Column 6: LOD - length of day [ms]
%
% -----
% NOTE:
% -----
%   --> N = # of data entries
%
%==========================================================================
function eop = load_eop(MJD_UTC0,duration)

    % loads full data set
    eop = struct2array(load('eop.mat'));

    % determines if inputs are provided
    MJD_UTC0_input = (nargin >= 1) && ~isempty(MJD_UTC0);
    duration_input = (nargin == 2) && ~isempty(duration);
    
    % trims data set to only keep relevant data for simulation
    if MJD_UTC0_input && duration_input

        % start and end dates of data to keep (from start to end of sim)
        MJD_start = floor(MJD_UTC0);
        MJD_end = ceil(MJD_UTC0+duration/24);
    
        % start and end indices
        i_start = interval_search(eop(:,1),MJD_start,false);
        [~,i_end] = interval_search(eop(:,1),MJD_end,false);
    
        % removes unnecessary data
        eop = eop(i_start:i_end,:);

    end

end