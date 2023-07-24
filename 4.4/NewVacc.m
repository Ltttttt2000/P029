%{
This combine SIV ode function and Euler together 
time-related
sigma 只变一次 phi接种率会先减小后增加
%}

function [t,r,withoutpolicy,sigmachange] = NewVacc(tspan,yI,N)

% S:x(1) I:x(2) 
tc = 5;          % 30 days has new vaccination
g = 1;            % intensity of measurements
sigma0 = 0.3;       % effectiveness of the vaccination sigma=1 vaccinati
beta = 0.5;
gamma = 0.1;

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
sigmachange = [sigma0];
count =0;  


for k = 1:N   %time h:day
    if k < tc
        sigma = sigma0;
        count = 0;  % If the infected people lower than threshold, the government will not implement the policy.
    elseif k >= tc 
        delta = 0.6;
        sigma = (1-g*delta)*sigma0;
        count = count + 1;
    end

    without = without(:,1)+newodefunction(without(:,1),beta,sigma0, gamma);
    y(:,1) = y(:,1)+newodefunction(y(:,1),beta,sigma, gamma);

%     fprintf('Time: %d S0: %.2f I0: %.2f phi0: %.2f S:%.2f I:%.2f phi:%.2f count:%d\n', ...
%         k,without(1,1),without(2,1),phi0,y(1,1),y(2,1),phi,count);
    yv = [y(1,1);y(2,1)];

    withoutpolicy = [withoutpolicy without];
    r = [r yv];
    t = [t k];
    sigmachange = [sigmachange sigma];
%     fprintf('beta: %f count: %d\n', beta,count);

end


% fprintf('S: %d I: %d\n', y(1,:),y(2,:));
end