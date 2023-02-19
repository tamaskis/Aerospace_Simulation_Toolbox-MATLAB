%==========================================================================
%
% get_similarity_transform  Obtains the matrix P defining the similarity 
% transformation B = P^(-1)AP.
%
%   P = get_similarity_transform(A,B)
%
% See also TODO.
%
% Copyright © 2021 Tamas Kis
% Last Update: 2021-10-26
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TECHNICAL DOCUMENTATION:
% TODO
%
% REFERENCES:
%   [1] TODO
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   A       - (n×n double) matrix 1
%   B       - (n×n double) matrix 2
%
% -------
% OUTPUT:
% -------
%   P       - (n×n double) matrix defining the similarity transformation 
%                          from A to B
%
%==========================================================================
function P = get_similarity_transform(A,B)
    
    % check if matrix is invertible
    
    % Jordan normal form
    [VA,JA] = jordan(A);
    [VB,JB] = jordan(B);
    
    
    %VB1 = VB(1,:);
    %VB2 = VB(2,:);
    
    %VB(1,:) = VB2;
    %VB(2,:) = VB1;
    
    % similarity transformation
    P = VA/VB;
    %P = JA/JB;
    %P = VB/VA;
    
end