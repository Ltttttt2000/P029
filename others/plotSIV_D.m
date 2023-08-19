figure;

tspan = [0 100];   % days

% Initial proportion of susceptible and infectious people
S0 = 0.7;
I0 = 0.3;

p0 = [S0; I0];

h = 1;  % time step 
N = (tspan(2)-tspan(1))/h;

% Euler methods
% t1 时间vector; Eulerp返回的S和I; nonewvacc:没有新疫苗出现的情况;phis变化
[t1,Eulerp,non,betas,sigmas,gammas] = NewOutbreak(tspan,p0,N);

subplot(2,3,1);
plot(t1, non(1,:),'r')
hold on;
plot(t1, non(2,:),'b')
hold on;
plot(t1, Eulerp(1,:))
hold on;
plot(t1, Eulerp(2,:))
legend('S no new vaccination','I no new vaccination','S has new vaccination','I has new vaccination');
xlabel('time')
ylabel('proportion')
title('New vaccines will appear after the disease spreads for a certain period of time')

subplot(2,3,2);
plot(Eulerp(1,:),Eulerp(2,:))
xlabel('S');
ylabel('I');
title('phase plane')

subplot(2,3,3);
plot(t1, sigmas);
xlabel('time')
ylabel('value')
title('The changes of phi and sigma');

subplot(2,3,4);
plot(t1, betas);
xlabel('time')
ylabel('value')
title('The changes of phi and sigma');

subplot(2,3,5);
plot(t1, gammas);
xlabel('time')
ylabel('value')
title('The changes of phi and sigma');

subplot(2,3,6);
% different initial state 定义多种不同的初始值
p02 = [0.6; 0.4];
[t2,Eulerp2,non2,betas2,sigmas2,gammas2] = NewOutbreak(tspan,p02,N);
p03 = [0.2; 0.2];
[t3,Eulerp3,non3,betas3,sigmas3,gammas3] = NewOutbreak(tspan,p03,N);
plot(Eulerp(1,:),Eulerp(2,:))
hold on;
plot(Eulerp2(1,:),Eulerp2(2,:))
hold on;
plot(Eulerp3(1,:),Eulerp3(2,:))
xlabel('S')
ylabel('I')
