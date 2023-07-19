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
Ic1 = 0.35;
Ic2 = 0.4;
Ics = [Ic1 Ic2];

% How to choose the two eplisons
eplison1 = 0.5;
eplison2 = 0.2;
eplisons = [eplison1; eplison2];

beta0 = 0.5;

[t1,Eulerp,withoutpolicy,betas] = twothreshold_delay(tspan,p0,N, Ics,beta0,eplisons,10);

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
yline(Ic2,'b');
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
p02 = [0.6; 0.4];
[t2,Eulerp2,withoutpolicy2,betas2] = twothreshold_delay(tspan,p02,N,Ics,beta0, eplisons,10);

p03 = [0.8; 0.2];
[t3,Eulerp3,withoutpolicy3,betas3] = twothreshold_delay(tspan,p03,N,Ics,beta0, eplisons,10);

p04 = [0.2, 0.5];
[t4,Eulerp4,withoutpolicy4,betas4] = twothreshold_delay(tspan,p04,N,Ics,beta0, eplisons,10);

p05 = [0.4, 0.6];
[t5,Eulerp5,withoutpolicy5,betas5] = twothreshold_delay(tspan,p05,N,Ics,beta0, eplisons,10);


subplot(2,2,4);
hold on;
plot(Eulerp(1,:),Eulerp(2,:));
plot(Eulerp2(1,:),Eulerp2(2,:));
plot(Eulerp3(1,:),Eulerp3(2,:));
plot(Eulerp4(1,:),Eulerp4(2,:));
plot(Eulerp5(1,:),Eulerp5(2,:));
hold off;

legend('[0.7,0.3]', '[0.6; 0.4]', '[0.8; 0.2]','[0.2, 0.5]','[0.4, 0.6]')
xlabel('S')
ylabel('I')
title('Different initial [S0, I0]')

% saveas(gcf, '2 thresholds','png')

% [Pxx,f] = periodogram(susceptible)


