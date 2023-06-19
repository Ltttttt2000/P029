figure;

tspan = [0 300];   % days
S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 
h = 1;
N = (tspan(2)-tspan(1))/h;  % one day

% Euler methods
% Eulerp: the vector[s,i] with threshold policy
% withoutpolicy: vector[s,i] without policy
% betas: the beta changes when threshold policy
[t1,Eulerp,withoutpolicy] = naturalmodel(tspan,p0,N);
% tol = 1e-12;
tol = 1e-5;
for i = 1:length(withoutpolicy)-1
%     fprintf("%d %d\n", withoutpolicy(1,i),withoutpolicy(2,i));
    diff_S = withoutpolicy(1,i+1) - withoutpolicy(1,i);
    diff_I = withoutpolicy(2,i+1) - withoutpolicy(2,i);

    if abs(diff_S) < tol && abs(diff_I) < tol
        fprintf("Difference: %d, %d\n", diff_S, diff_I);
        fprintf("The steady state of (S, I): %.2f, %.2f\n", withoutpolicy(1,i),withoutpolicy(2,i));
        break;
    end
end 

plot(t1, withoutpolicy(1,:),'r')
hold on;
plot(t1, withoutpolicy(2,:),'b')

legend('S','I');
xlabel('time')
ylabel('population')
title('The natural situation, without policy')