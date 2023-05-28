%{
This combine SIV ode function and Euler together 
time-related
sigma 只变一次 phi接种率会先减小后增加
%}

function [t,r,withoutpolicy,phichange,sigmachange] = ModelB(tspan,yI,N)

% S:x(1) I:x(2) 
phi0 = 0.07;         % infection rate bigger means no effect
tc = 30;          % 30 days has new vaccination
g = 0.6;            % intensity of measurements
sigma0 = 0.3;       % effectiveness of the vaccination sigma=1 vaccinati

% Forward Euler method
tI = tspan(1);
tF = tspan(2);
h = (tF - tI)/N;

d = numel(yI);  % return the size of yI
y = zeros(d, N+1);
y(:,1) = yI;  % 2*1 matrix y(1,1)=S, y(2,1)=I
without(:,1) = yI;
withoutpolicy(:,1) = yI;

r(:,1) = yI;
t = [0];
phichange = [0.07];
sigmachange = [0.3];
count =0;  


for k = 1:N   %time h:day
    % eplison should be 0-1
%       eplison = 0.5;  % 数字越大，持续封锁措施时间越长
%      eplison = randomwalk(k);    
%        eplison = sigmoid(0.05*k);  % have oscillation
    if k < tc
        phi = phi0;
        sigma = sigma0;
        count = 0;  % If the infected people lower than threshold, the government will not implement the policy.
    elseif k >= tc && count<10
        delta = sigmoid(count*0.1);
        phi = (1-g*delta)*phi0;
        sigma = 0.1;
        count = count + 1;
    elseif k>=tc && count>=10
        delta = sigmoid(count-10);  % 更合理
        phi = ((1-g*sigmoid(1))*phi0+g*delta)*phi0; 
        sigma = 0.1;
        count = count + 1;
    end

    without = without(:,1)+functionB(without(:,1),phi0,sigma0);
    y(:,1) = y(:,1)+functionB(y(:,1),phi,sigma);

    fprintf('Time: %d S0: %.2f I0: %.2f phi0: %.2f S:%.2f I:%.2f phi:%.2f count:%d\n', ...
        k,without(1,1),without(2,1),phi0,y(1,1),y(2,1),phi,count);
    yv = [y(1,1);y(2,1)];

    withoutpolicy = [withoutpolicy without];
    r = [r yv];
    t = [t k];
    phichange = [phichange phi];
    sigmachange = [sigmachange sigma];
%     fprintf('beta: %f count: %d\n', beta,count);

end


% fprintf('S: %d I: %d\n', y(1,:),y(2,:));
end