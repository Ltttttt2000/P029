% for only one threshold policy (e.g. lockdown)


S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 

% Euler methods
% Eulerp: the vector[s,i] with threshold policy
% withoutpolicy: vector[s,i] without policy
% betas: the beta changes when threshold policy
Ic = 0.5;
beta0 = 0.5;
eplison = 0.5;

% Day
tspan = [0 20];   % days
h = 1/24;
N = (tspan(2)-tspan(1))/h;  % one hour

[t1,Eulerp,withoutpolicy,betas,daysofpolicy, dayswithoutpolicy] = basicmodel_hour(tspan,p0,N,Ic, beta0,eplison);

figure;
subplot(2,2,1)
plot(t1, withoutpolicy(1,:),'r')
hold on;
plot(t1, withoutpolicy(2,:),'b')
hold on;
plot(t1, Eulerp(1,:))
hold on;
plot(t1, Eulerp(2,:))
legend('S origin','I origin','S','I');
xlabel('time')
ylabel('population')
    
title('The population of susceptible and intected people')
% susceptible = Eulerp(1,20:100);
% infected = Eulerp(2,20:100);
% 
% max_S = max(susceptible);
% min_S = min(susceptible);
% amplitude_S = max_S - min_S;
% 
% max_I = max(infected);
% min_I = min(infected);
% amplitude_I = max_I - min_I;
% 
% [pks,locs] = findpeaks(susceptible);
% [pks_I,locs_I] = findpeaks(infected);
% 
% if isempty(locs)
%     amplitude_S = 0;
% end
% 
% if isempty(locs_I)
%     amplitude_I = 0;
% end
% 
% 
% fprintf("%d,%d\n", daysofpolicy, dayswithoutpolicy);
% percentage = daysofpolicy /(daysofpolicy + dayswithoutpolicy);
% fprintf("%.2f\n",percentage);
% fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);

% [Pxx,f] = periodogram(susceptible)

subplot(2,2,2);
scatter(Eulerp(1,:),Eulerp(2,:))
xlabel('S');
ylabel('I');
title('phase plane')

% the beta changes verus time
subplot(2,2,3);
plot(t1, betas)
xlabel('time')
ylabel('beta')
title('The changes of beta')

p02 = [0.6; 0.4];
[t2,Eulerp2,withoutpolicy2,betas2,daysofpolicy2,dayswithoutpolicy2] = basicmodel_hour(tspan,p02,N,Ic, beta0,eplison);

p03 = [0.8; 0.2];
[t3,Eulerp3,withoutpolicy3,betas3,daysofpolicy3,dayswithoutpolicy3] = basicmodel_hour(tspan,p03,N,Ic, beta0,eplison);

p04 = [0.2, 0.5];
[t4,Eulerp4,withoutpolicy4,betas4,daysofpolicy4,dayswithoutpolicy4] = basicmodel_hour(tspan,p04,N,Ic, beta0,eplison);

p05 = [0.4, 0.6];
[t5,Eulerp5,withoutpolicy5,betas5,daysofpolicy5,dayswithoutpolicy5] = basicmodel_hour(tspan,p05,N,Ic, beta0,eplison);


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