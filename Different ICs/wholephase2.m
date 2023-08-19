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
Ic2 = 0.93;
Ics = [Ic1 Ic2];

% How to choose the two eplisons
eplison1 = 0.5;
eplison2 = 0.2;
eplisons = [eplison1; eplison2];

beta0 = 0.5;
delay = 12;
[t1,Eulerp,withoutpolicy,betas] = twothreshold4(tspan,p0,N, Ics,beta0,eplisons,delay);



% fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);
p02 = [0.6; 0.4];
[t2,Eulerp2,withoutpolicy2,betas2] = twothreshold4(tspan,p02,N,Ics,beta0, eplisons,delay);

p03 = [0.8; 0.2];
[t3,Eulerp3,withoutpolicy3,betas3] = twothreshold4(tspan,p03,N,Ics,beta0, eplisons,delay);

p04 = [0.2, 0.5];
[t4,Eulerp4,withoutpolicy4,betas4] = twothreshold4(tspan,p04,N,Ics,beta0, eplisons,delay);

p05 = [0.4, 0.6];
[t5,Eulerp5,withoutpolicy5,betas5] = twothreshold4(tspan,p05,N,Ics,beta0, eplisons,delay);

p06 = [0.2, 0.2];
[t6,Eulerp6,withoutpolicy6,betas6] = twothreshold4(tspan,p06,N,Ics,beta0, eplisons,delay);

p07 = [0.2, 0.3];
[t7,Eulerp7,withoutpolicy7,betas7] = twothreshold4(tspan,p07,N,Ics,beta0, eplisons,delay);

p08 = [0.8, 0.5];
[t8,Eulerp8,withoutpolicy8,betas8] = twothreshold4(tspan,p08,N,Ics,beta0, eplisons,delay);

p09 = [0.6, 0.5];
[t9,Eulerp9,withoutpolicy9,betas9] = twothreshold4(tspan,p09,N,Ics,beta0, eplisons,delay);

p10 = [0.7, 0.8];
[t10,Eulerp10,withoutpolicy10,betas10] = twothreshold4(tspan,p10,N,Ics,beta0, eplisons,delay);


% set(gcf,'unit','centimeters','position',[10 5 30 10]);
% name = "Ic1=" + num2str(Ics(1,1))+",Ic2="+ num2str(Ic2);
% sgtitle(name);
% subplot(1,2,1)
% hold on;
% plot(Eulerp(1,:),Eulerp(2,:));
% plot(Eulerp2(1,:),Eulerp2(2,:));
% plot(Eulerp3(1,:),Eulerp3(2,:));
% plot(Eulerp4(1,:),Eulerp4(2,:));
% plot(Eulerp5(1,:),Eulerp5(2,:));
% plot(Eulerp6(1,:),Eulerp6(2,:));
% plot(Eulerp7(1,:),Eulerp7(2,:));
% plot(Eulerp8(1,:),Eulerp8(2,:));
% plot(Eulerp9(1,:),Eulerp9(2,:));
% plot(Eulerp10(1,:),Eulerp10(2,:));
% hold off;
% xlabel('S')
% ylabel('I')
% title('Different initial states')



% subplot(1,2,2)
figure;
hold on;
scatter(Eulerp(1,:),Eulerp(2,:));
scatter(Eulerp2(1,:),Eulerp2(2,:));
scatter(Eulerp3(1,:),Eulerp3(2,:));
scatter(Eulerp4(1,:),Eulerp4(2,:));
scatter(Eulerp5(1,:),Eulerp5(2,:));
scatter(Eulerp6(1,:),Eulerp6(2,:));
scatter(Eulerp7(1,:),Eulerp7(2,:));
scatter(Eulerp8(1,:),Eulerp8(2,:));
scatter(Eulerp9(1,:),Eulerp9(2,:));
scatter(Eulerp10(1,:),Eulerp10(2,:));
yline(Ic1,'r');
fplot(@(x) Ic2-x,[0,1]);
hold off;


xlim([0.35 0.7])
xlabel('S')
ylabel('I')
name = "Different Initial States of Ic1=" + num2str(Ics(1,1))+",Ic2="+ num2str(Ic2);
title(name)
set(gcf,'position',[500,200,350,250])