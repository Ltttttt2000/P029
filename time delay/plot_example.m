% for only one policy (lockdown)

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


% delay = [0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
delay = 10;
[t1,Eulerp,withoutpolicy,betas] = timedelay(tspan,p0,N,delay);

figure;
name = "time delay (days) = " + num2str(delay);
sgtitle(name);
% subplot(1,2,1);
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
% title('SIV, when reach threshold, implement policy')
set(gcf,'position',[100,50,500,300]);

susceptible = Eulerp(1,40:100);
infected = Eulerp(2,40:100);

max_S = max(susceptible);
min_S = min(susceptible);
amplitude_S = max_S - min_S;

max_I = max(infected);
min_I = min(infected);
amplitude_I = max_I - min_I;

amplitudes(A,1) = amplitude_S;
amplitudes(A,2) = amplitude_I;
fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);


% different initial state 定义多种不同的初始值
% subplot(1,2,2);
% p02 = [0.6; 0.4];
% [t2,Eulerp2,withoutpolicy2,betas2] = timedelay(tspan,p02,N,delay);
% p03 = [0.2; 0.2];
% [t3,Eulerp3,withoutpolicy3,betas3] = timedelay(tspan,p03,N,delay);
% p04 = [0.2; 0.7];
% [t4,Eulerp4,withoutpolicy4,betas4] = timedelay(tspan,p04,N,delay);
% p05 = [0.5; 0.2];
% [t5,Eulerp5,withoutpolicy5,betas5] = timedelay(tspan,p05,N,delay);
% p06 = [0.7; 0.8];
% [t6,Eulerp6,withoutpolicy6,betas6] = timedelay(tspan,p06,N,delay);
% p07 = [0.2; 0.5];
% [t7,Eulerp7,withoutpolicy7,betas7] = timedelay(tspan,p07,N,delay);
% p08 = [0.8; 0.4];
% [t8,Eulerp8,withoutpolicy8,betas8] = timedelay(tspan,p08,N,delay);
% p09 = [0.2; 0.2];
% [t9,Eulerp9,withoutpolicy9,betas9] = timedelay(tspan,p09,N,delay);
% 
% hold on;
% scatter(Eulerp(1,:),Eulerp(2,:))
% scatter(Eulerp2(1,:),Eulerp2(2,:))
% scatter(Eulerp3(1,:),Eulerp3(2,:))
% scatter(Eulerp4(1,:),Eulerp4(2,:))
% scatter(Eulerp5(1,:),Eulerp5(2,:))
% scatter(Eulerp6(1,:),Eulerp6(2,:))
% scatter(Eulerp7(1,:),Eulerp7(2,:))
% scatter(Eulerp8(1,:),Eulerp8(2,:))
% scatter(Eulerp9(1,:),Eulerp9(2,:))
% xlabel('S')
% ylabel('I')
% yline(0.5)
% % xlim([0.42,0.56])
% title('phase graph')
% set(gcf,'position',[100,50,500,200]);


