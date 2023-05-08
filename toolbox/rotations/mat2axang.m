%==========================================================================
%
% mat2axang  Rotation matrix to axis-angle representation.
%
%   [e,Phi] = mat2axang(R)
%
% See also axangle2eul_321, axang2mat, axang2quat, eul2axang_321,
% eul2mat_321, eul2quat_321, mat2eul_321, mat2quat, quat2axang,
% quat2eul_321, quat2mat.
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
%   R       - (3×3 double) rotation matrix
%
% -------
% OUTPUT:
% -------
%   e       - (3×1 double) principal rotation vector
%   Phi     - (1×1 double) principal angle [rad]
%
% -----
% NOTE:
% -----
%   • ||e|| = 1
%   • Φ ∈ [0,π]
%   • If Φ = 0, then e is returned as (1,0,0)ᵀ.
%
%==========================================================================
function [e,Phi] = mat2axang(R)
    
    % cosine of the principal angle
    c = (R(1,1)+R(2,2)+R(3,3)-1)/2;
    
    % ensures |c| ≤ 1
    c = imax(imin(c,1),-1);
    
    % edge case #1: cos(Φ) = 1
    if iabs(c-1) < 1e-11
        
        % principal rotation vector
        e = [1;0;0];
        
        % principal angle [rad]
        Phi = 0;
        
    % edge case #2: cos(Φ) = -1
    elseif iabs(c+1) < 1e-11
        
        % principal angle [rad]
        Phi = pi;
        
        % auxiliary matrix
        A = R+eye(3,3);
        
        % determines principal rotation vector as first nonzero column of A
        %   • if non nonzero column is found, then e = 0
        e = zeros(3,1);
        for i = 1:3
            if inorm(A(:,i)) > 1e-3
                e = A(:,i);
                break;
            end
        end
        
    % base case
    else
        
        % sine of the principal angle
        s = sqrt(1-c^2);
        
        % principal angle
        Phi = iatan2(s,c);
        
        % principal rotation vector
        e = [R(2,3)-R(3,2);
             R(3,1)-R(1,3);
             R(1,2)-R(2,1)];
        
        % ensures that Φ ∈ [0,π]
        if Phi < 0
            Phi = Phi+pi;
            e = -e;
        end
        
    end
    
    % normalizes principal rotation vector
    e = e/inorm(e);
    
end