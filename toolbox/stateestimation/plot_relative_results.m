%==========================================================================
%
% plot_relative_results  Plots the results of state estimation of the
% deputy relative ECI state resolved in the chief RTN frame.
%
%   plot_relative_results(t,dX,dP,dX_true,M)
%
% Author: Tamas Kis
% Last Update: 2022-03-14
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   t           - (1×N double) time vector
%   dX          - (6×N double) estimated deputy relative ECI state resolved
%                 in chief's RTN frame (time history) [m][m/s]
%   dP          - (6×6×N double) relative state error covariance (time 
%                 history) [m^2][m^2/s^2]
%   dX_true     - (6×N double) true relative ECI state resolved in chief's
%                 RTN frarme (time history) [m][m/s]
%   M           - (OPTIONAL) (1×1 double) number of standard deviations for
%                 bounds (defaults to 1)
%                   --> for example, M = 2 returns ±2σ
%
%==========================================================================
function plot_relative_results(t,dX,dP,dX_true,M)

    % defaults "M" to 1 if not input
    if (nargin < 4) || isempty(M)
        M = 1;
    end
    
    % converts time to hours
    t = t/3600;

    % calculates covariance bounds
    [dX_lower,dX_upper] = covariance_bounds(dX,dP,M);
    
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
    opts.name = '$\delta r_{R}$';
    plot_filter_results(t',dX(1,:),dX_lower(1,:),dX_upper(1,:),...
        dX_true(1,:),opts);
    
    % J position
    subplot(3,2,3);
    opts.name = '$\delta r_{T}$';
    plot_filter_results(t',dX(2,:),dX_lower(2,:),dX_upper(2,:),...
        dX_true(2,:),opts);
    
    % K position
    subplot(3,2,5);
    opts.name = '$\delta r_{N}$';
    plot_filter_results(t',dX(3,:),dX_lower(3,:),dX_upper(3,:),...
        dX_true(3,:),opts);
    
    % ---------------
    % Velocity plots.
    % ---------------
    
    % velocity units
    opts.xunits = "m/s";
    
    % I position
    subplot(3,2,2);
    opts.name = '$\delta v_{R}$';
    plot_filter_results(t',dX(4,:),dX_lower(4,:),dX_upper(4,:),...
        dX_true(4,:),opts);
    
    % J position
    subplot(3,2,4);
    opts.name = '$\delta v_{T}$';
    plot_filter_results(t',dX(5,:),dX_lower(5,:),dX_upper(5,:),...
        dX_true(5,:),opts);
    
    % K position
    subplot(3,2,6);
    opts.name = '$\delta v_{N}$';
    plot_filter_results(t',dX(6,:),dX_lower(6,:),dX_upper(6,:),...
        dX_true(6,:),opts);
    
end