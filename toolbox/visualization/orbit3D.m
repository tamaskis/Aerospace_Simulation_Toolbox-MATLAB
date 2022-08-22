%==========================================================================
%
% orbit3D  Plots an orbit in 3D.
%
%   orbit3D(r)
%   orbit3D(r,opts)
%
% Author: Tamas Kis
% Last Update: 2021-12-12
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r       - (3×N or N×3 double) matrix of N 3×1 or 1×3 position vectors
%   opts    - (struct) plot options
%       • Color     - (char or 1×3 double) line color (defaults to
%                     [0,0.4470,0.7410]) [rgb]
%                       --> can be specified as a name, short name, or RGB
%                           triplet
%       • LineStyle - (1×1 double) line style
%       • LineWidth - (1×1 double) line width
%
%==========================================================================
function orbit3D(r,opts)
    
    % ------------------------------------
    % Sets (or defaults) plotting options.
    % ------------------------------------

    % sets line color (defaults to default MATALB color)
    if (nargin == 1) || ~isfield(opts,'Color')
        Color = [0,0.4470,0.7410];
    else
        Color = opts.Color;
    end

    % sets line style (defaults to solid line)
    if (nargin == 1) || ~isfield(opts,'LineStyle')
        LineStyle = '-';
    else
        LineStyle = opts.LineStyle;
    end

    % sets line width (defaults to 1.5)
    if (nargin == 1) || ~isfield(opts,'LineWidth')
        LineWidth = 1.5;
    else
        LineWidth = opts.LineWidth;
    end

    % --------------------
    % Exracts coordinates.
    % --------------------
    
    % determines if position array is oriented vertically or horizontally
    if size(r,1) > size(r,2)
        vertical = true;
    else
        vertical = false;
    end

    % extracts coordinates
    if vertical
        x = r(:,1);
        y = r(:,2);
        z = r(:,3);
    else
        x = r(1,:);
        y = r(2,:);
        z = r(3,:);
    end

    % ------------
    % Plots orbit.
    % ------------

    plot3(x,y,z,'Color',Color,'LineStyle',LineStyle,'LineWidth',LineWidth);
    
end