function dy=SIV(t,x)
% S:x(1) I:x(2) 
beta = 0.5;         % infection rate
sigma = 0.3;       % effectiveness of the vaccination sigma=1 vaccination no effect
mu = 0.05;             % natural birth/death rate
gamma = 0.1;        % recovery rate
theta = 0.002;       % rate of loss of community
phi = 0.007;          % vaccination rate

Ic = 0.4;
% eplison = sigmoid(t);        % change eplison
% eplison = sigmoid(t-3);
eplison = randomwalk(t);
f = 0.2;            % intensity of measurements

if x(2) < Ic
    beta = 0.5;
else
    beta = (1-f*eplison)*beta;
end

dy(1,1) = mu - beta * x(1) * x(2) - (mu + theta + phi) * x(1) + (gamma - theta) * x(2) + theta;
dy(2,1) = beta * x(1) * x(2) + sigma * beta * x(2) * (1 - x(1) - x(2)) - (mu + gamma) * x(2);
      
  