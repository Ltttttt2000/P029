function [t,r,withoutpolicy] = naturalmodel(tspan,yI,N)


% S:x(1) I:x(2) 

beta = 0.5;   % initial beta

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


fprintf('The initial population: S:%.2f, I:%.2f\n', y(1,1),y(2,1));

for k = 1:N   %time h:day

    without = without(:,1)+odefunction(without(:,1),beta);

    yv = [y(1,1);y(2,1)];

    withoutpolicy = [withoutpolicy without];
    r = [r yv];
    t = [t k];
%     fprintf('beta: %f count: %d\n', beta,count);

end

fprintf('==================================================\n');
end