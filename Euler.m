function [t,y] = Euler(f,tspan,yI,N, count)
% Forward Euler method
tI = tspan(1);
tF = tspan(2);
h = (tF - tI)/N;

d = numel(yI);  % return the size of yI
y = zeros(d, N+1);
y(:,1) = yI;
t=linspace(tI,tF,N+1)'; 
for k = 1:N
    y(:,k+1) = y(:,k)+h*f(t(k),y(:,k));
end


% fprintf('S: %d I: %d\n', y(1,:),y(2,:));
end