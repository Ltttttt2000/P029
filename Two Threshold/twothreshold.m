% This combine SIV ode function and Euler together 
% change the beta 

function [t,r,withoutpolicy,betachange] = twothreshold(tspan,yI,N, Ics,beta0,eplisons)

% S:x(1) I:x(2) 

Ic1 = Ics(1,1);
Ic2 = Ics(2,1);
eplison1 = eplisons(1,1);
eplison2 = eplisons(2,1);
% change threshold

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


fprintf('The initial population: S:%.2f, I:%.2f\n', y(1,1),y(2,1));

for k = 1:N   %time h:day
    % eplison should be 0-1
%       eplison = 0.5;  % 数字越大，持续封锁措施时间越长
%      eplison = randomwalk(k);    
%        eplison = sigmoid(0.05*k);  % have oscillation

    if y(2,1) < Ic1
        beta = 0.5;
    elseif y(2,1) >=Ic1 && y(2,1) < Ic2
        beta = (1-f*eplison1)*beta0; 
    elseif y(2,1)>=Ic2
        beta = (1-f*eplison1)*(1-f*eplison2)*beta0;
    end

    without = without(:,1)+odefunction(without(:,1),beta0);
    y(:,1) = y(:,1)+odefunction(y(:,1),beta);

    fprintf('Day %d S0: %.2f I0: %.2f initial infected rate: %.2f S:%.2f I:%.2f infected rate:%.2f\n', ...
        k,without(1,1),without(2,1),beta0,y(1,1),y(2,1),beta);
    
    yv = [y(1,1);y(2,1)];

    withoutpolicy = [withoutpolicy without];
    r = [r yv];
    t = [t k];
    betachange = [betachange beta];
%     fprintf('beta: %f count: %d\n', beta,count);

end

fprintf('==================================================\n');
end