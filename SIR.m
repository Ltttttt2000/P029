function dy=SIR(t,x)
% if x(1)>0.5
%     beta = 0.04
% else
%    beta = 0.3;    % infected rate
% end
beta = 0.15;
gamma = 0.03;    % recovery rate
% beta = 0.1;
% gamma = 0.005;
dy=[beta*x(1)*x(2)-gamma*x(1);
    -beta*x(1)*x(2)];