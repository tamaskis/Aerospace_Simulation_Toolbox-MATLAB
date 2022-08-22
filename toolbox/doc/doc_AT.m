%==========================================================================
%
% doc_AT  Opens the documentation for the Astrodynamics Toolbox.
%
%   doc_NDT
%   doc_NDT function_name
%   doc_NDT tech
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   name   - (char) name of the function
%               --> using "tech" opens the technical documentation
%
%==========================================================================
function doc_AT(name)

    % opens index if no function name specified
    if nargin == 0
        web('html_AT/index.html');

        % TODO
%     % opens technical documentation
%     elseif strcmpi(name,'tech')
%         open(strcat('Numerical_Differentiation_using_the_Complex_Step',...
%             '_Approximation.pdf'));
        
    % opens specified function documentation
    else
        web(strcat('html_AT/',name,'_doc.html'));

    end
end