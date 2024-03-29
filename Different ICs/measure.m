% for only one threshold policy (e.g. lockdown)
% 查看S+I, S-I的变化来确定新的IC2的方式
tspan = [0 50];   % days
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
Ic2 = 0.39;
Ics = [Ic1 Ic2];

% How to choose the two eplisons
eplison1 = 0.5;
eplison2 = 0.2;
eplisons = [eplison1; eplison2];

beta0 = 0.5;

[t1,Eulerp,withoutpolicy,betas] = basicmodel(tspan,p0,N, Ic1,beta0,eplison1);

figure;
name = "Ic1=" + num2str(Ics(1,1)) + " in basicmodel";
sgtitle(name);
% subplot(2,3,1)
% plot(t1, withoutpolicy(1,:),'r')
% hold on;
% plot(t1, withoutpolicy(2,:),'b')
% hold on;
% plot(t1, Eulerp(1,:))
% hold on;
% plot(t1, Eulerp(2,:))
% yline(Ic1,'r');

% legend('S origin','I origin','S','I');
% xlabel('time')
% ylabel('population')
% 
% title('The population of susceptible and intected people')
% subplot(2,3,2);
% plot(t1, betas,'*')
% xlabel('time')
% ylabel('beta')
% title('The changes of beta')

% the beta changes verus time

set(gcf,'unit','centimeters','position',[10 5 30 8]);
subplot(1,4,1);
plot(t1, Eulerp(1,:)-Eulerp(2,:))  % 越小越不好
xlabel('time')
ylabel('S-I')
title('S-I in lockdown')

subplot(1,4,2);
plot(t1, Eulerp(1,:)+Eulerp(2,:))
xlabel('time')
ylabel('S+I')
title('S+I in lockdown')

subplot(1,4,3)
plot(t1, withoutpolicy(1,:)+withoutpolicy(2,:))
xlabel('time')
ylabel('S+I')
title('S+I without policy')


subplot(1,4,4)
plot(t1, withoutpolicy(1,:)-withoutpolicy(2,:))
xlabel('time')
ylabel('S-I')
title('S-I without policy')

saveas(gcf, 'determinants','png')

% [Pxx,f] = periodogram(susceptible)


