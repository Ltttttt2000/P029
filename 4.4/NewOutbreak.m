%{
This combine SIV ode function and Euler together 
to pass parameter "count"

%}

function [t,r,withoutpolicy,betachange, sigmachange,gammachange] = NewOutbreak(tspan,yI,N)

% S:x(1) I:x(2) 
tc = 5;
gamma0 = 0.1; 
beta0 = 0.5;         % infection rate
sigma0 = 0.3;   


% Forward Euler method
tI = tspan(1);
tF = tspan(2);
h = (tF - tI)/N;

d = numel(yI);  % return the size of yI
y = zeros(d, N+1);
y(:,1) = yI;  % 2*1 matrix y(1,1)=S, y(2,1)=I
without(:,1) = yI;
withoutpolicy(:,1) = yI;
t=linspace(tI,tF,N+1)'; 
r(:,1) = yI;
t = [0];
gammachange = [gamma0];
betachange = [beta0];
sigmachange = [sigma0];
count =0;  


for k = 1:N   %time h:day
    if k < tc
        gamma = gamma0;
        beta = beta0;
        sigma = sigma0;
        count = 0;  % If the infected people lower than threshold, the government will not implement the policy.
    elseif k >= tc 
        delta = 2;
        gamma = (1+delta)*gamma0;
        x = 0.6;
        sigma = (1-x)*sigma0;
        beta = (1-0.5)*beta0;
        count = count + 1;
    end

    without = without(:,1)+newodefunction(without(:,1),beta0,sigma0,gamma0);
    y(:,1) = y(:,1)+newodefunction(y(:,1),beta,sigma,gamma);
%     fprintf('Time: %d S0: %.2f I0: %.2f beta0: %.2f S:%.2f I:%.2f beta:%.2f count:%d\n', ...
%         k,without(1,1),without(2,1),beta0,y(1,1),y(2,1),beta,count);
    yv = [y(1,1);y(2,1)];

    withoutpolicy = [withoutpolicy without];
    r = [r yv];
    t = [t k];
    gammachange = [gammachange gamma];
    betachange = [betachange beta];
    sigmachange = [sigmachange sigma];
%     fprintf('beta: %f count: %d\n', beta,count);

end


% fprintf('S: %d I: %d\n', y(1,:),y(2,:));
end