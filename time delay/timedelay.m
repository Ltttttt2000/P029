% This combine SIV ode function and Euler together 
% change the beta 

function [t,r,withoutpolicy,betachange] = timedelay(tspan,yI,N,delay)

% S:x(1) I:x(2) 
beta0 = 0.5;         % infection rate when there is no policy

Ic = 0.5;           % the threshold of infectious people
f = 1;            % intensity of measurements


% Forward Euler method
tI = tspan(1);
tF = tspan(2);
h = (tF - tI)/N;

d = numel(yI);  % return the size of yI
y = zeros(d, N+1);
y(:,1) = yI;  % 2*1 matrix y(1,1)=S, y(2,1)=I

% To plot the situation when there is no policy
without(:,1) = yI;
withoutpolicy(:,1) = yI;

t=linspace(tI,tF,N+1)'; 

r(:,1) = yI;      % return the ode solution

t = 0;
betachange = beta0;

count =0;  

fprintf('The initial population: S:%.2f, I:%.2f\n', y(1,1),y(2,1));
policytime = 0;
for k = 1:N   %time h:day
    % eplison should be 0-1
%       eplison = 0.5;  % 数字越大，持续封锁措施时间越长
%      eplison = randomwalk(k);    
%        eplison = sigmoid(0.05*k);  % have oscillation

    if y(2,1) < Ic
        policytime = 0;
        beta = 0.5;
        count = 0;  % If the infected people lower than threshold, the government will not implement the policy.
    elseif y(2,1) >=Ic && count <delay
        beta = 0.5;
        count = count + 1;
        policytime = 0;
    elseif y(2,1) >=Ic && count >=delay
%          eplison = sigmoid(count-10);
         eplison = 0.5;
%         eplison = randomwalk(count -10);  % 更合理
        beta = (1-f*eplison)*beta0; 
        count = count + 1;  % 表示执行计划开始的时间 eplision越大 beta越小
        policytime = policytime + 1;
    end

    without = without(:,1)+odefunction(without(:,1),beta0);
    y(:,1) = y(:,1)+odefunction(y(:,1),beta);

    fprintf('Time: %d S0: %.2f I0: %.2f beta0: %.2f S:%.2f I:%.2f beta:%.2f count:%d policytime:%d\n', ...
        k,without(1,1),without(2,1),beta0,y(1,1),y(2,1),beta,count,policytime);
    
    yv = [y(1,1);y(2,1)];

    withoutpolicy = [withoutpolicy without];
    r = [r yv];
    t = [t k];
    betachange = [betachange beta];
%     fprintf('beta: %f count: %d\n', beta,count);

end

fprintf('==================================================\n');
end