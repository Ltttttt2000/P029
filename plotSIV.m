figure;

tspan = [0 50];
S0 = 0.7;
I0 = 0.3;

p0 = [S0; I0];
h = 0.5;
N = (tspan(2)-tspan(1))/h;
% myEuler methods
[t1,Eulerp] = Euler(@SIV2,tspan,p0,N);
plot(t1, Eulerp(1,:),'b')
hold on;
plot(t1, Eulerp(2,:),'r')
legend('S','I');
title('SIV')

figure;
plot(Eulerp(1,:),Eulerp(2,:))

% [t,h] = ode45(@SIV,[0 300],[0.7, 0.3]);  %[初始感染人口占比 初始健康人口占比 初始免疫人口占比]
% plot(t,h(:,1),'r');
% hold on;
% plot(t,h(:,2),'b');
% legend('S','I');
% title('SIV')
% 
% figure;
% plot(h(:,1),h(:,2))

% [t,h] = ode15s(@SIV,[0 300],[0.98, 0.02]);  %[初始感染人口占比 初始健康人口占比 初始免疫人口占比]
% plot(t,h(:,1),'r');
% hold on;
% plot(t,h(:,2),'b');
% legend('S','I');
% title('SIV')
% 
% figure;
% plot(h(:,1),h(:,2))