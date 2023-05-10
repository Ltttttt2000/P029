function y = f(x,beta)

sigma = 0.3;       % effectiveness of the vaccination sigma=1 vaccination no effect
mu = 0.05;             % natural birth/death rate
gamma = 0.1;        % recovery rate
theta = 0.002;       % rate of loss of community
phi = 0.07;          % vaccination rate 0.07

Ic = 0.4;
f = 0.2;            % intensity of measurements

y(1,1) = mu - beta * x(1) * x(2) - (mu + theta + phi) * x(1) + (gamma - theta) * x(2) + theta;
y(2,1) = beta * x(1) * x(2) + sigma * beta * x(2) * (1 - x(1) - x(2)) - (mu + gamma) * x(2);

end
