% for only one threshold policy (e.g. lockdown)
% steady state will change

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

% change the parameters in Ic, beta0, eplison
% the threshold of infectious people
% infection rate when there is no policy


beta0s = [0.1; 0.2; 0.3; 0.4; 0.5; 0.6; 0.7;0.8;0.9;1.0];
eplison = 0.5;
threshold = 0.5;    
amplitudes = zeros(length(beta0s),2);
differences = zeros(length(beta0s),2);
for A = 1:length(beta0s)
    [t1,Eulerp,withoutpolicy,betas] = basicmodel(tspan,p0,N,threshold,beta0s(A,1), eplison);  

    tol = 1e-5;
    for i = 1:length(withoutpolicy)-1
        fprintf("%d %d\n", withoutpolicy(1,i),withoutpolicy(2,i));
        diff_S = withoutpolicy(1,i+1) - withoutpolicy(1,i);
        diff_I = withoutpolicy(2,i+1) - withoutpolicy(2,i);
    
        if abs(diff_S) < tol && abs(diff_I) < tol
            fprintf("Difference: %d, %d\n", diff_S, diff_I);
            fprintf("The steady state of (S, I): %.2f, %.2f\n", withoutpolicy(1,i),withoutpolicy(2,i));
            differences(A,1) = withoutpolicy(1,i);
            differences(A,2) = withoutpolicy(2,i);
            break;
        end
    end 

end


figure;
plot(beta0s, differences(:,1));
hold on;
plot(beta0s, differences(:,2));
hold off;
title("steady state of oscillation with difference beta")
xlabel('initial beta');
ylabel('steady state')
legend('S', 'I');
set(gcf,'position',[100,50,500,200]);
saveas(gcf,"steady-beta0",'png');