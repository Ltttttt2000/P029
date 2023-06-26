figure;

tspan = [0 100];   % days
S0 = 0.8;
I0 = 0.2;

p0 = [S0; I0];
h = 1;
N = (tspan(2)-tspan(1))/h;

% % without policy
% [t0,Eulerp0] = Euler(@SIV_origin,tspan,p0,N);
% plot(t0, Eulerp0(1,:),'b')
% hold on;
% plot(t1, Eulerp0(2,:),'r')
% legend('S','I');
% title('SIV without policy')
% figure;
% plot(Eulerp0(1,:),Eulerp0(2,:))
% xlabel('S');
% ylabel('I');
% figure;

% Euler methods

% [t1,Eulerp, rcount] = Euler(@SIV2,tspan,p0,N, count);
[t1,Eulerp,withoutpolicy,betas] = ModelA(tspan,p0,N);

subplot(2,2,1);
plot(t1, withoutpolicy(1,:),'r')
hold on;
plot(t1, withoutpolicy(2,:),'b')
hold on;
plot(t1, Eulerp(1,:))
hold on;
plot(t1, Eulerp(2,:))
legend('S_origin','I_origin','S','I');
xlabel('time')
ylabel('population')
title('SIV, when reach threshold, implement policy')

subplot(2,2,2);
plot(Eulerp(1,:),Eulerp(2,:))
xlabel('S');
ylabel('I');
title('phase plane')

subplot(2,2,3);
plot(t1, betas)
xlabel('time')
ylabel('beta')
title('The changes of beta')

% subplot(2,2,4);
% % different initial state 定义多种不同的初始值
% p02 = [0.6; 0.4];
% [t2,Eulerp2,withoutpolicy2,betas2] = ModelA(tspan,p02,N);
% p03 = [0.2; 0.2];
% [t3,Eulerp3,withoutpolicy3,betas3] = ModelA(tspan,p03,N);
% plot(Eulerp(1,:),Eulerp(2,:))
% hold on;
% plot(Eulerp2(1,:),Eulerp2(2,:))
% hold on;
% plot(Eulerp3(1,:),Eulerp3(2,:))
% xlabel('S')
% ylabel('I')
