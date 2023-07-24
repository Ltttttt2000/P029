function y = functionB(x,phi,sigma)

% phi and sigma are changable

beta = 0.5;
mu = 0.1;          % natural birth/death rate 0.05
gamma = 0.1;        % recovery rate 0.1
theta = 0.5;      % rate of loss of community 0.002

y(1,1) = mu - beta * x(1) * x(2) - (mu + theta + phi) * x(1) + (gamma - theta) * x(2) + theta;
y(2,1) = beta * x(1) * x(2) + sigma * beta * x(2) * (1 - x(1) - x(2)) - (mu + gamma) * x(2);

end
