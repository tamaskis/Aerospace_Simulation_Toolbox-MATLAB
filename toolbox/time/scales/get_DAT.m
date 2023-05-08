%==========================================================================
%
% get_dat  Obtains the difference between TAI and UTC (ΔAT = TAI - UTC).
%
%   DAT = get_dat(MJD)
%
% See also get_dut1.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-05-07
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
%   MJD     - (1×1 double) modified Julian date of any time scale [MJD]
%
% -------
% OUTPUT:
% -------
%   DAT    - (1×1 double) leap seconds (difference between TAI 
%            (International Atomic Time) and UTC (Universal Coordinated 
%            Time) [s]
%
% -----
% NOTE:
% -----
%   • ΔAT = TAI - UTC
%
%==========================================================================
function DAT = get_dat(MJD)
    
    % loads ΔAT data
    %   • first column is the date in MJD
    %   • second column is ΔAT in seconds
    DAT_data = load_numeric_data('DAT.mat');
    
    % extracts x and y vectors
    x = DAT_data(:,1);
    y = DAT_data(:,2);
    
    % gets length of data
    N = length(x);
    
    % edge case: specified date is after last available date
    if MJD > x(N)
        DAT = y(N);
        
    % base case: specified date is either (a) before first available date
    % in the data set or (b) contained within the available dates in the 
    % data set
    else
        
        % finds the lower bound of interval containing specified date
        [l,~] = find_interval(x,MJD);
        
        % extracts leap seconds from data table
        DAT = y(l);
        
    end
    
end