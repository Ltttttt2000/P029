% for only one threshold policy (e.g. lockdown)

tspan = [0 100];   % days
S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 
h = 1;
N = (tspan(2)-tspan(1))/h;  % one day

% Euler methods
% Eulerp: the vector[s,i] with threshold policy
% withoutpolicy: vector[s,i] without policy
% betas: the beta changes when threshold policy
Ic = 0.5;
beta0 = 0.5;
eplison = 0.5;


[t1,Eulerp,withoutpolicy,betas,daysofpolicy, dayswithoutpolicy] = basicmodel(tspan,p0,N,Ic, beta0,eplison);

figure;
plot(t1, withoutpolicy(1,:),'r')
hold on;
plot(t1, withoutpolicy(2,:),'b')
hold on;
plot(t1, Eulerp(1,:))
hold on;
plot(t1, Eulerp(2,:))
legend('S origin','I origin','S','I','FontSize',15);
xlabel('time',FontSize=15)
ylabel('population',FontSize=15)
set(gcf,'position',[100,50,500,300])



title('The population of susceptible and intected people','FontSize',16)
saveas(gcf,'oscillation','png')
susceptible = Eulerp(1,80:100);
infected = Eulerp(2,80:100);

max_S = max(susceptible);
min_S = min(susceptible);
amplitude_S = max_S - min_S;

max_I = max(infected);
min_I = min(infected);
amplitude_I = max_I - min_I;

[pks,locs] = findpeaks(susceptible);
[pks_I,locs_I] = findpeaks(infected);

if isempty(locs)
    amplitude_S = 0;
end

if isempty(locs_I)
    amplitude_I = 0;
end


fprintf("%d,%d\n", daysofpolicy, dayswithoutpolicy);
percentage = daysofpolicy /(daysofpolicy + dayswithoutpolicy);
fprintf("%.2f\n",percentage);
fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);

% [Pxx,f] = periodogram(susceptible)

