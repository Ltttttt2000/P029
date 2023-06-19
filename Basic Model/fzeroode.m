
sigma = 0.3;        % effectiveness of the vaccination sigma=1 vaccination no effect 0.3
mu = 0.1;          % natural birth/death rate 0.05
gamma = 0.1;        % recovery rate 0.1
theta = 0.5;      % rate of loss of community 0.002
phi = 0.1;         % vaccination rate  0.07

beta = 0.5;
% dS = mu - beta * S * I - (mu + theta + phi) * S + (gamma - theta) * I + theta;
% dI = beta * S * I + sigma * beta * I * (1 - S - I) - (mu + gamma) * I;
% 
% fzero(@(x) odefunc(x, y0), [a, b]);

% Define the system of equations
equations = @(variables) [
    mu - beta * variables(1) * variables(2) - (mu + theta + phi) * variables(1) + (gamma - theta) * variables(2) + theta;
    beta * variables(1) * variables(2) + sigma * beta * variables(2) * (1 - variables(1) - variables(2)) - (mu + gamma) * variables(2)
];

% Set initial guess for the variables
variables_guess = [0.5; 0.5];

% Solve the system of equations using fsolve
variables_steady = fsolve(equations, variables_guess);
% variables_steady = fzero(@equations, variables_guess);
% Extract the steady state values
S_steady = variables_steady(1);
I_steady = variables_steady(2);
