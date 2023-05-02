function dy=SIV(t,x)
% S:x(1) I:x(2) 
beta = 0.4;         % infection rate
sigma = 0.03;       % effectiveness of the vaccination sigma=1 vaccination no effect
mu = 0.5;             % natural birth/death rate
gamma = 0.01;        % recovery rate
theta = 0.02;       % rate of loss of community
phi = 0.07;          % vaccination rate

Ic = 0.4;
eplison = 1;
f = 0.2;            % intensity of measurements

% if x(2) >Ic
%     beta = (1-f*eplison)*beta;
% end 

dy = [  mu - beta * x(1) * x(2) - (mu + theta + phi) * x(1) + (gamma - theta) * x(2) + theta
        beta * x(1) * x(2) + sigma * beta * x(2) * (1 - x(1) - x(2)) - (mu + gamma) * x(2);
        ];
  