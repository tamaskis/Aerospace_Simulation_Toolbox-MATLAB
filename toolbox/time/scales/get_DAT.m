%==========================================================================
%
% get_DAT  Obtains the difference between TAI and UTC (ΔAT = TAI - UTC).
%
%   DAT = get_DAT(MJD)
%
% See also get_DUT1.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-01
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
%   MJD     - (1×1 double) modified Julian date (any time scale) [MJD]
%
% -------
% OUTPUT:
% -------
%   DAT    - (1×1 double) difference between TAI (International Atomic 
%            Time) and UTC (Universal Coordinated Time) [s]
%               --> ΔAT = TAI - UTC
%
%==========================================================================
function DAT = get_DAT(MJD)
    
    % loads DAT data
    %   --> first column is the date in MJD
    %   --> second column is DAT in seconds
    DAT_data = load_numeric_data('DAT.mat');
    
    % truncates date to beginning of day
    MJD = floor(MJD);
    
    % if date is after the latest available data, set it to latest date in
    % data table
    if MJD > DAT_data(end,1)
        MJD = DAT_data(end,1);
    end
    
    % if date is before the first available date, throw an error
    if (MJD < DAT_data(1,1))
        error('ΔAT data not available for specified date.');
    end
    
    % extracts DAT from data
    index = interval_search(DAT_data(:,1),MJD);
    DAT = DAT_data(index,2);
    
end