% Parameters
a = 1.0;              % Advection speed
L = 1.0;              % Domain length
Nx = 100;             % Number of spatial points
x = linspace(0, L, Nx);
dx = x(2) - x(1);
dt = 0.005;
CFL = a * dt / dx;    % CFL number (should be <= 1 for stability)

% Initial condition: Gaussian pulse centered at x = 0.5
u = exp(-100 * (x - 0.5).^2);

% Time stepping setup
t = 0;
t_max = L / a;        % Time for pulse to travel across domain

% Visualization setup
figure;
axis([0 L 0 1]);
xlabel('x');
ylabel('u(x,t)');
title('1D Advection: Upwind Scheme');
grid on;
hold on;

% Time stepping loop
while t < t_max
    % Apply upwind scheme (left-biased)
    u(2:end) = u(2:end) - CFL * (u(2:end) - u(1:end-1));
    
    % Outflow boundary condition: zero at left edge
    u(1) = 0;

    % Plot every 0.2 units of time
    if mod(round(t/dt), 40) == 0
        plot(x, u, 'LineWidth', 2);
        drawnow;
    end

    % Advance time
    t = t + dt;
end

legend('t = 0.2', 't = 0.4', 't = 0.6', 't = 0.8', 't = 1.0');
