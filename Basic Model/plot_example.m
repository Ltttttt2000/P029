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

% change the parameters in Ic, beta0, eplison
% the threshold of infectious people
% infection rate when there is no policy
parameters = [0.5, 0.5, 0.5];

[t1,Eulerp,withoutpolicy,betas] = basicmodel(tspan,p0,N,parameters(1,1),parameters(1,2),parameters(1,3));
figure;
subplot(2,2,1);
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

% the phase plane S-I
subplot(2,2,2);
plot(Eulerp(1,:),Eulerp(2,:))
xlabel('S');
ylabel('I');
title('phase plane')

% the beta changes verus time
subplot(2,2,3);
plot(t1, betas)
xlabel('time')
ylabel('beta')
title('The changes of beta')

% different initial state 定义多种不同的初始值
subplot(2,2,4);
p02 = [0.6; 0.4];
[t2,Eulerp2,withoutpolicy2,betas2] = basicmodel(tspan,p02,N,parameters(1,1),parameters(1,2),parameters(1,3));

p03 = [0.8; 0.2];
[t3,Eulerp3,withoutpolicy3,betas3] = basicmodel(tspan,p03,N,parameters(1,1),parameters(1,2),parameters(1,3));

p04 = [0.2, 0.5];
[t3,Eulerp4,withoutpolicy4,betas4] = basicmodel(tspan,p04,N,parameters(1,1),parameters(1,2),parameters(1,3));

p05 = [0.4, 0.6];
[t3,Eulerp5,withoutpolicy5,betas5] = basicmodel(tspan,p05,N,parameters(1,1),parameters(1,2),parameters(1,3));

plot(Eulerp(1,:),Eulerp(2,:))
hold on;
plot(Eulerp2(1,:),Eulerp2(2,:))
hold on;
plot(Eulerp3(1,:),Eulerp3(2,:))
hold on;
plot(Eulerp4(1,:),Eulerp4(2,:))
hold on;
plot(Eulerp5(1,:),Eulerp5(2,:))

legend('[0.7,0.3]', '[0.6; 0.4]', '[0.8; 0.2]','[0.2, 0.5]','[0.4, 0.6]')
xlabel('S')
ylabel('I')
title('Different initial [S0, I0]')


saveas(gcf, 'example', 'png');



