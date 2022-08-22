%==========================================================================
%
% plot_absolute_results  Plots the results of state estimation of the
% absolute ECI state.
%
%   plot_absolute_results(t,X,X_true,X_lower,X_upper)
%
% Author: Tamas Kis
% Last Update: 2022-03-14
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   t           - (1×N double) time vector [s]
%   X           - (6×N double) estimated ECI state (time history) [m][m/s]
%   P           - (6×6×N double) ECI state error covariance (time history) 
%                 [m^2][m^2/s^2]
%   X_true      - (6×N double) true ECI state (time history) [m][m/s]
%   M           - (OPTIONAL) (1×1 double) number of standard deviations for
%                 bounds (defaults to 1)
%                   --> for example, M = 2 returns ±2σ
%
%==========================================================================
function plot_absolute_results(t,X,P,X_true,M)
    
    % defaults "M" to 1 if not input
    if (nargin < 4) || isempty(M)
        M = 1;
    end

    % converts time to hours
    t = t/3600;
    
    % calculates covariance bounds
    [X_lower,X_upper] = sigma_bounds(X,P,M);
    
    % settings for all plots
    opts.shaded = true;
    opts.color = [0,0.4470,0.7410];
    opts.error = true;
    opts.M = M;
    opts.figure = false;
    
    % initializes figure
    figure('Position',[270,300,1200,1000])

    % time axis units for all plots
    opts.tunits = "h";
    
    % ---------------
    % Position plots.
    % ---------------
    
    % position units
    opts.xunits = "m";
    
    % I position
    subplot(3,2,1);
    opts.name = '$r_{I}$';
    plot_filter_results(t',X(1,:),X_lower(1,:),X_upper(1,:),X_true(1,:),...
        opts);
    
    % J position
    subplot(3,2,3);
    opts.name = '$r_{J}$';
    plot_filter_results(t',X(2,:),X_lower(2,:),X_upper(2,:),X_true(2,:),...
        opts);
    
    % K position
    subplot(3,2,5);
    opts.name = '$r_{K}$';
    plot_filter_results(t',X(3,:),X_lower(3,:),X_upper(3,:),X_true(3,:),...
        opts);
    
    % ---------------
    % Velocity plots.
    % ---------------
    
    % velocity units
    opts.xunits = "m/s";
    
    % I position
    subplot(3,2,2);
    opts.name = '$v_{I}$';
    plot_filter_results(t',X(4,:),X_lower(4,:),X_upper(4,:),X_true(4,:),...
        opts);
    
    % J position
    subplot(3,2,4);
    opts.name = '$v_{J}$';
    plot_filter_results(t',X(5,:),X_lower(5,:),X_upper(5,:),X_true(5,:),...
        opts);
    
    % K position
    subplot(3,2,6);
    opts.name = '$v_{K}$';
    plot_filter_results(t',X(6,:),X_lower(6,:),X_upper(6,:),X_true(6,:),...
        opts);
    
end