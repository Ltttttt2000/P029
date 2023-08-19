tspan = [0 120];   % days
S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 
h = 1;
N = (tspan(2)-tspan(1))/h;  % one day


Ivalues_I = [];
Ivalues_S = [];
SI_values = [];
Ic2s = [];
Ic2s_S = [];
Ic2SI = [];
beta_value = [];
beta_x = [];
% 固定Ic1,看Ic2的变化对oscillation的影响
% Ic1=0.56 steady state Ic1 = 0.2<initial I; Ic1 = 0.3=Initial I; Ic1 =
% 0.35; Ic1 = 0.4.

percentage1 = zeros(length(0.9:0.01:0.95),1);
percentage2 = zeros(length(0.9:0.01:0.95),1);
percentage3 = zeros(length(0.9:0.01:0.95),1);
percentage4 = zeros(length(0.9:0.01:0.95),1);
xx = zeros(length(0.9:0.01:0.95),1);
beta0 = 0.5;
eplison1 = 0.5;
eplison2 = 0.2;
eplisons = [eplison1; eplison2];
i = 1;

Ic1 = 0.37;
delay = 0;
for Ic2 = 0.9:0.01:0.95
    [t1,Eulerp,withoutpolicy,betas,days] = twothreshold4(tspan,p0,N, [Ic1,Ic2],beta0,eplisons,delay);
    [peaks_I, peakIdx_I] = findpeaks(Eulerp(2,:));

    % 找到局部极小值
    [troughs_I, troughIdx_I] = findpeaks(-Eulerp(2,:));
    troughs_I = -troughs_I;

    length_max = length(peaks_I);
    length_min = length(troughs_I);

    total = length_min+length_max;
    x_I = zeros(1,total)+Ic2;
    y_I = [peaks_I,troughs_I];

    Ivalues_I = [Ivalues_I,y_I];
    Ic2s = [Ic2s, x_I];

    x_beta = zeros(1,length(betas))+Ic2;
    beta_x = [beta_x,x_beta];
    beta_value = [beta_value, betas];
  
    [peaks_S, peakIdx_S] = findpeaks(Eulerp(1,:));
    % 找到局部极小值
    [troughs_S, troughIdx_S] = findpeaks(-Eulerp(1,:));
    troughs_S = -troughs_S;

    length_max_S = length(peaks_S);
    length_min_S = length(troughs_S);

    total_S = length_min_S + length_max_S;
    x_S = zeros(1,total_S)+Ic2;
    y_S = [peaks_S,troughs_S];

    Ivalues_S = [Ivalues_S,y_S];
    Ic2s_S = [Ic2s_S, x_S];

    

    if isempty(peakIdx_I)
        Ic2s_S = [];
        Ivalues_S = [];
        Ivalues_I = [];
        Ic2s = [];
    end

    [peaks_SI, peakIdx_SI] = findpeaks(Eulerp(1,:)+Eulerp(2,:));
    [troughs_SI, troughIdx_SI] = findpeaks(-(Eulerp(1,:)+Eulerp(2,:)));
    troughs_SI = -troughs_SI;
    length_max = length(peaks_SI);
    length_min = length(troughs_SI);
    totalSI = length_min+length_max;
    x_I = zeros(1,totalSI)+Ic2;
    y_I = [peaks_SI,troughs_SI];

    SI_values = [SI_values,y_I];
    Ic2SI = [Ic2SI, x_I];


    days1 = days(1,1);
    days2 = days(1,2);
    days3 = days(1,3);
    days4 = days(1,4);
    daystotal = days1 + days2 + days3 + days4;
    percentage1(i,1) = days1 /daystotal;
    percentage2(i,1) = days2 /daystotal;
    percentage3(i,1) = days3 /daystotal;
    percentage4(i,1) = days4 /daystotal;
    xx(i,1) = Ic2;
    fprintf('%f\n',percentage2(i,1))
    i = i +1;
    

end

figure;
subplot(1,2,1)
plot(Ic2s, Ivalues_I,'*');
xlabel('Ic2 = S + I')
ylabel('Infected group proportion (I) values')
title('Peaks and Nadirs of (I) values')
yline(Ic1,'r','Linewidth',2);

subplot(1,2,2)
scatter(Ic2SI, SI_values)
hold on;
fplot(@(x) x,[0.9,0.95],'r','Linewidth',2);
hold off;
xlabel('Ic2 = S + I')
ylabel('S+I values')
title('Peaks and Nadirs of (S+I) values')
set(gcf,'position',[500,200,800,300])

% figure;
% subplot(2,1,1)
% plot(Ic2s, Ivalues_I,'*');
% xlabel('Ic2 = S - I')
% ylabel('Infected group proportion (I) values')
% title('Peaks and Nadirs of (I) values')
% yline(Ic1,'r','Linewidth',2);
% 
% % figure;
% % plot(Ic2s_S, Ivalues_S,'*');
% % xlabel('Ic2')
% % ylabel('Susceptible group proportion (S) values')
% % title('Peaks and Nadirs of (S) values vs Ic2')
% 
% subplot(2,1,2)
% plot(beta_x, beta_value,'*');
% xlabel('The second threshold (Ic2 = S - I)')
% ylabel('Beta changes')
% title('Bifurcation diagram betas')

figure;
% set(gcf,'unit','centimeters','position',[10 5 30 8]);
hold on;
plot(xx(:,1),percentage1(:,1),'LineWidth',2);
plot(xx(:,1),percentage2(:,1),'LineWidth',2);
plot(xx(:,1),percentage3(:,1),'LineWidth',2);
plot(xx(:,1),percentage4(:,1),'LineWidth',2);
legend('No policy', 'Lockdown', 'Border Control','Combined policy')
xlabel('threshold Ic2')
ylabel('percentage of days')
title('Days of different States')
set(gcf,'position',[500,200,700,200])
% % saveas(gcf,'percentage-newic','png')