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
Ic1 = 0.37;
Ic2 = 0.17;
Ics = [Ic1 Ic2];

% How to choose the two eplisons
eplison1 = 0.5;
eplison2 = 0.2;
eplisons = [eplison1; eplison2];

beta0 = 0.5;

[t1,Eulerp,withoutpolicy,betas] = Ic2_S(tspan,p0,N, Ics,beta0,eplisons);

figure;
name = "Ic1=" + num2str(Ics(1,1))+",Ic2="+ num2str(Ics(1,2));
sgtitle(name);
subplot(2,2,1)
plot(t1, withoutpolicy(1,:),'r')
hold on;
plot(t1, withoutpolicy(2,:),'b')
hold on;
plot(t1, Eulerp(1,:))
hold on;
plot(t1, Eulerp(2,:))
yline(Ic1,'r');
% 
legend('S origin','I origin','S','I');
xlabel('time')
ylabel('population')

title('The population of susceptible and intected people')
subplot(2,2,2);
scatter(Eulerp(1,:),Eulerp(2,:))
xlabel('S');
ylabel('I');
title('phase plane')

% the beta changes verus time
subplot(2,2,3);
plot(t1, betas,'*')
xlabel('time')
ylabel('beta')
title('The changes of beta')

fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);


subplot(2,2,4);
plot(t1, Eulerp(1,:)-Eulerp(2,:))  % 越小越不好
xlabel('time')
ylabel('S-I')
yline(Ic2,'r');
title('S-I')


% saveas(gcf, '2 thresholds','png')

% [Pxx,f] = periodogram(susceptible)


