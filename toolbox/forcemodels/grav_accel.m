%==========================================================================
%
% grav_accel  Gravitational acceleration using a spherical harmonic model.
%
%   g_pcpf = grav_accel(r_pcpf,mu,R,C,S,N,M)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2024-01-02
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
%   r_pcpf  - (3×1 double) position expressed in planet-centered
%             planet-fixed (PCPF) frame [m]
%   mu      - (1×1 double) standard gravitational parameter [m³/s²]
%   R       - (1×1 double) reference radius [m]
%   C       - (L×1 double) unnormalized coefficient vector
%   S       - (L×1 double) unnormalized coefficient vector
%   N       - (1×1 double) maximum degree
%   M       - (1×1 double) maximum order
%
% -------
% OUTPUT:
% -------
%   g_pcpf  - (3×1 double) inertial gravitational acceleration expressed in
%             planet-centered planet-fixed (PCPF) frame [m/s²]
%   V       - (L₃×1 double) Legendre coefficient vector
%   W       - (L₃×1 double) Legendre coefficient vector
%
%==========================================================================
function [g_pcpf,V,W] = grav_accel(r_pcpf,mu,R,C,S,N,M)
    
    % recursively computes the Legendre coefficients
    [V,W] = legendre_recursion(r_pcpf,R,N+1,M+1);
    
    % auxiliary parameter [m/s²]
    a = mu/(2*R^2);
    
    % initializes the accelerations [m/s²]
    gX = 0;
    gY = 0;
    gZ = 0;
    
    % calculates the accelerations
    for n = 0:N
        
        % TODO
        l1 = grav_model_index(n+1,1);
        
        % zonal potential coefficient
        Cn0 = C(grav_model_index(n,0));
        
        % zonal terms (m = 0)
        gX = gX-2*a*Cn0*V(l1);
        gY = gY-2*a*Cn0*W(l1);
        gZ = gZ-2*a*(n+1)*Cn0*V(grav_model_index(n+1,0));
        
        % truncates at the specified maximum order
        m_end = min(n,M);
        
        % sectorial (m = n) and tesseral (n > m) terms
        for m = 1:m_end
            
            % auxiliary parameter
            b = (m-n-2)*(m-n-1);
            
            % TODO
            l2 = grav_model_index(n,m);
            l3 = grav_model_index(n+1,m+1);
            l4 = grav_model_index(n+1,m-1);
            l5 = grav_model_index(n+1,m);
            
            % gravitational coefficients
            Cnm = C(l2);
            Snm = S(l2);
            
            % accelerations due to gravity [m/s²]
            gX = gX-a*(Cnm*V(l3)+Snm*W(l3))+a*b*(Cnm*V(l4)+Snm*W(l4));
            gY = gY+a*(Snm*V(l3)-Cnm*W(l3))+a*b*(Snm*V(l4)-Cnm*W(l4));
            gZ = gZ-2*a*(n-m+1)*(Cnm*V(l5)+Snm*W(l5));
            
        end
        
    end
    
    % gravitational acceleration resolved in ECEF frame [m/s²]
    g_pcpf = [gX;
              gY;
              gZ];
    
end