%==========================================================================
%
% get_DUT1  Obtains the difference between UT1 and UTC (ΔUT1 = UT1 - UTC).
%
%   DUT1 = get_DUT1(MJD)
%
% Author: Tamas Kis
% Last Update: 2022-01-22
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD     - (1×1 double) modified Julian date (any time scale) [MJD]
%
% -------
% OUTPUT:
% -------
%   DUT1    - (1×1 double) difference between UT1 (Universal Time 1) and 
%             UTC (Universal Coordinated Time) [s]
%               --> ΔUT1 = UT1 - UTC
%
%==========================================================================
function DUT1 = get_DUT1(MJD)
    
    % loads DUT1 data
    %   --> first column is the data in MJD
    %   --> second column is DUT1 in seconds
    DUT1_data = struct2array(load('DUT1.mat'));

    % truncates to beginning of day
    MJD = floor(MJD);

    % if date is before the first available date, throw an error
    if (MJD < DUT1_data(1,1))
        error('ΔUT1 data not available for specified date.');
    end

    % if date is after last available date, throw an error
    if (MJD > DUT1_data(end,1))
        error('ΔUT1 data not available for specified date.');
    end
    
    % extracts DUT1 from data
    DUT1 = DUT1_data(DUT1_data(:,1)==MJD,2);

end