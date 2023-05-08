%==========================================================================
%
% get_dut1  Obtains the difference between UT1 and UTC (ΔUT1 = UT1 - UTC).
%
%   DUT1 = get_DUT1(MJD)
%
% See also get_dat.
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
%   DUT1    - (1×1 double) difference between UT1 (Universal Time 1) and 
%             UTC (Universal Coordinated Time) [s]
%
% -----
% NOTE:
% -----
%   • ΔUT1 = UT1 - UTC
%
%==========================================================================
function DUT1 = get_dut1(MJD)
    
    % loads ΔUT1 data
    %   • first column is the date in MJD
    %   • second column is ΔAT in seconds
    DUT1_data = load_numeric_data('DUT1.mat');
    
    % extracts x and y vectors
    x = DUT1_data(:,1);
    y = DUT1_data(:,2);
    
    % gets length of data
    N = length(x);
    
    % edge case: specified date is after last available date
    if MJD > x(N)
        DUT1 = y(N);
        
    % base case: specified date is either (a) before first available date
    % in the data set or (b) contained within the available dates in the 
    % data set
    else
        
        % finds the lower bound of interval containing specified date
        [l,~] = find_interval(x,MJD);
        
        % extracts ΔUT1 from data table
        DUT1 = y(l);
        
    end
    
end