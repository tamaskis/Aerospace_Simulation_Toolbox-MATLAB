%==========================================================================
%
% abs2rel_filter_results  Deputy relative ECI state resolved in chief's RTN
% frame from chief and deputy absolute ECI states.
%
%   dX = abs2rel_filter_results(Xd,Xc)
%   [dX,dP] = abs2rel_filter_results(Xd,Xc,Pd,Pc)
%
% Author: Tamas Kis
% Last Update: 2022-03-14
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   Xd      - (6×K double) deputy ECI state (time history) [m][m/s]
%   Xc      - (6×K double) chief ECI state (time history) [m][m/s]
%   Pd      - (6×6×K double) (OPTIONAL) deputy ECI state error covariance 
%             (time history) [m^2][m^2/s^2]
%   Pc      - (6×6×K double) (OPTIONAL) chief ECI state error covariance 
%             (time history) [m^2][m^2/s^2]
%
% -------
% OUTPUT:
% -------
%   dX      - (6×K double) deputy relative ECI state resolved in chief's
%              RTN frame [m][m/s]
%   dP      - (6×K double) error covariance of deputy relative ECI state 
%             resolved in chief's RTN frame [m][m/s]
%
%==========================================================================
function [dX,dP] = abs2rel_filter_results(Xd,Xc,Pd,Pc)
    
    % determines if error covariances input
    calculate_covariance = (nargin == 4) && ~isempty(Pd) && ~isempty(Pc);

    % number of sample times
    K = size(Xd,2);

    % deputy relative ECI state resolved in ECI frame [m][m/s]
    dX_eci = Xd-Xc;

    % preallocates arrays to store results
    dX = zeros(6,K);
    if calculate_covariance, dP = zeros(6,6,K); end

    % resolving relative states in chief's RTN frame
    for k = 1:K
        
        % chief position [m] and inertial velocity [m/s] resolved in ECI
        % frame
        rc_eci = Xc(1:3,k);
        vc_eci = Xc(4:6,k);

        % rotation matrix from ECI frame to chief RTN frame
        R_eci2rtn = eci2rtn_matrix(rc_eci,vc_eci);

        % transformation matrix
        S = [R_eci2rtn    zeros(3,3);
             zeros(3,3)   R_eci2rtn];

        % resolves deputy relative ECI state in chief's RTN frame
        dX(:,k) = S*dX_eci(:,k);
        
        % transforms covariance of relative state to chief's RTN frame
        if calculate_covariance
            dP(:,:,k) = S*(Pd(:,:,k)+Pc(:,:,k))*S.';
        end

    end
    
end