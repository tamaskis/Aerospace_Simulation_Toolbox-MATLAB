%==========================================================================
%
% vec2rot  Finds the rotation matrix between two coordinate frames given
% the same vector resolved in both of the frames.
%
%   R_A2B = vec2rot(vA,vB)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-04-17
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/documentation/Rotation_Matrix_From_Two_Coordinate_Vectors.pdf
%
% REFERENCES:
%   [1] https://math.stackexchange.com/questions/180418/calculate-rotation-matrix-to-align-vector-a-to-vector-b-in-3d
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   vA      - (3×1 double) vector resolved in coordinate frame A
%   vB      - (3×1 double) vector resolved in coordinate frame B
%
% -------
% OUTPUT:
% -------
%   R_A2B   - (3×3 double) rotation matrix from coordinate frame A to
%             coordinate frame B
%
%==========================================================================
function R_A2B = vec2rot(vA,vB)

    % normalizing vectors
    a = vA/norm(vA);
    b = vB/norm(vB);
    
    % dot and cross products of a and b
    d = dot(a,b);
    c = cross(a,b);
    
    % skew-symmetric cross product matrix of c
    vx = [ 0     -c(3)   c(2);
           c(3)   0     -c(1);
          -c(2)   c(1)   0];
    
    % rotation matrix from coordinate frame A to coordinate frame B
    R_A2B = eye(3)+vx+vx^2*(1/(1+d));
    
end