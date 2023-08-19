tspan = [0 100];   % days
S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 
h = 1;
N = (tspan(2)-tspan(1))/h;  % one day

beta0 = 0.5;
% How to choose the two eplisons
eplison1 = 0.5;
eplison2 = 0.2;
eplisons = [eplison1; eplison2];

Ivalues_I = [];
Ivalues_S = [];
Ic1s = [];
Ic1s_S = [];
beta_value = [];
beta_x = [];

Ic2 = 0.4;
delay = 0;
for Ic1 = 0.1:0.01:0.56
    [t1,Eulerp,withoutpolicy,betas] = twothreshold2(tspan,p0,N, [Ic1,Ic2],beta0,eplisons,delay);
    [peaks_I, peakIdx_I] = findpeaks(Eulerp(2,:));
    % 找到局部极小值
    [troughs_I, troughIdx_I] = findpeaks(-Eulerp(2,:));
    troughs_I = -troughs_I;

    length_max = length(peaks_I);
    length_min = length(troughs_I);


    total = length_min+length_max;
    x_I = zeros(1,total)+Ic1;
    y_I = [peaks_I,troughs_I];

    Ivalues_I = [Ivalues_I,y_I];
    Ic1s = [Ic1s, x_I];

    x_beta = zeros(1,length(betas))+Ic1;
    beta_x = [beta_x,x_beta];
    beta_value = [beta_value, betas];
  
    [peaks_S, peakIdx_S] = findpeaks(Eulerp(1,:));
    % 找到局部极小值
    [troughs_S, troughIdx_S] = findpeaks(-Eulerp(1,:));
    troughs_S = -troughs_S;

    length_max_S = length(peaks_S);
    length_min_S = length(troughs_S);

    total_S = length_min_S + length_max_S;
    x_S = zeros(1,total_S)+Ic1;
    y_S = [peaks_S,troughs_S];

    Ivalues_S = [Ivalues_S,y_S];
    Ic1s_S = [Ic1s_S, x_S];

    if isempty(peakIdx_I)
        Ic1s_S = [];
        Ivalues_S = [];
%         beta_x = [];
%         beta_value = [];
%         Ivalues_I = [];
%         Ic1s = [];
    end
end

% plot 1*2
% figure;
% name = "Ic2=" + num2str(Ic2);
% sgtitle(name);
% subplot(1,2,1)
% plot(Ic1s, Ivalues_I,'*');
% hold on;
% f = @(x) x;
% if isempty(Ivalues_I)
%     fplot(f,'LineWidth',2)
% else
%     fplot(f,[min(Ivalues_I),max(Ivalues_I)],'LineWidth',2)
% end
% text(0.3,Ic2+0.02,'Ic2')
% text(0.3,0.256,'Ic1')
% xlabel('Ic1')
% ylabel('Infected group proportion (I) values')
% title('Peaks and Nadirs of (I) values vs Ic2')
% yline(Ic2,'r','LineWidth',2);
% 
% subplot(1,2,2)
% plot(beta_x, beta_value,'*');
% xlabel('Ic1')
% ylabel('Beta changes')
% set(gcf,'position',[100,50,700,200]);
% title('Bifurcation diagram betas vs Ic1')


% % plot only scatter 
name = "Peaks and Nadirs of (I) values vs Ic2=" + num2str(Ic2);
plot(Ic1s, Ivalues_I,'*');
hold on;
f = @(x) x;
if isempty(Ivalues_I)
    fplot(f,'LineWidth',2)
else
    fplot(f,[min(Ivalues_I),max(Ivalues_I)],'LineWidth',2)
end
text(0.3,Ic2-0.02,'Ic2')
text(0.3,0.256,'Ic1')
xlabel('Ic1')
ylabel('Infected group proportion (I) values')
yline(Ic2,'r','LineWidth',2);
title(name)
set(gcf,'position',[100,50,500,200]);
