%==========================================================================
%
% generate_subrame_1  Subframe 1 of GPS navigation message from GPS data.
%
%   subframe1 = generate_subframe_1(file_name)
%
% Author: Tamas Kis
% Last Update: 2022-03-17
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   file_name   - (char) file name for GPS data
%
% -------
% OUTPUT:
% -------
%   subframe1   - (M×1 struct) subframe 1 parameters for "M" GPS satellites
%       • TGD       - (1×1 double) group differential delay [s]
%       • toc       - (1×1 double) clock data reference time [s]
%       • af2       - (1×1 double) drift rate correction coefficient 
%                     [s/s^2]
%       • af1       - (1×1 double) SV clock drift correction coefficient 
%                     [s/s]
%       • af0       - (1×1 double) SV clock bias correction coefficient [s]
%
%==========================================================================
function subframe1 = generate_subframe_1(file_name)
    
    % read in GPS data
    gps_data = readtable(file_name);

    % number of satellites in data set
    M = size(gps_data,1);

    % preallocates structure
    subframe1(M,1) = struct();

    % generates subframe 1 sub-structure for each satellite
    for k = 1:M
        subframe1(k).TGD = gps_data.TGD(k);
        subframe1(k).toc = gps_data.TransTime(k);
        subframe1(k).af2 = gps_data.SVclockDriftRate(k);
        subframe1(k).af1 = gps_data.SVclockDrift(k);
        subframe1(k).af0 = gps_data.SVclockBias(k);
    end
    
end