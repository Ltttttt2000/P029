function [dy, count]=SIV(t,x,count)

% set a count to indicate the process: must be global variable
% count = 0;
% S:x(1) I:x(2) 
beta = 0.5;         % infection rate
sigma = 0.3;       % effectiveness of the vaccination sigma=1 vaccination no effect
mu = 0.05;             % natural birth/death rate
gamma = 0.1;        % recovery rate
theta = 0.002;       % rate of loss of community
phi = 0.07;          % vaccination rate 0.07

Ic = 0.4;
% eplison = 1;
% eplison = sigmoid(t);        % change eplison
eplison = sigmoid(t-3);
% eplison = randomwalk(t);
f = 0.2;            % intensity of measurements


% before, after 
if x(2) < Ic
    beta = 0.5;
elseif x(2) >=Ic && count <10
    beta = 0.5;
    count = count + 1;
else
    beta = (1-f*eplison)*beta;    
end

dy(1,1) = mu - beta * x(1) * x(2) - (mu + theta + phi) * x(1) + (gamma - theta) * x(2) + theta;
dy(2,1) = beta * x(1) * x(2) + sigma * beta * x(2) * (1 - x(1) - x(2)) - (mu + gamma) * x(2);

fprintf('%f %d\n', beta,count);
  