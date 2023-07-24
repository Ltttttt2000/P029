tspan = [0 100];   % days
S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 
h = 1;
N = (tspan(2)-tspan(1))/h;  % one day

delay = [0;1;2;3;4;5;6;7;8;9;10];
Ivalues_I = [];
Times_I = [];
beta0 = 0.5;
% How to choose the two eplisons
eplison1 = 0.5;
eplison2 = 0.2;
eplisons = [eplison1; eplison2];
Ivalues_S = [];
Times_S = [];
beta_value = [];
beta_x = [];
Ic1 = 0.31;
Ic2 = 0.4;
Ics = [Ic1,Ic2];

for A = 1:length(delay)
    [t1,Eulerp,withoutpolicy,betas] = twothreshold2(tspan,p0,N, Ics,beta0,eplisons,delay(A,1));
    [peaks_I, peakIdx_I] = findpeaks(Eulerp(2,:));
    % 找到局部极小值
    [troughs_I, troughIdx_I] = findpeaks(-Eulerp(2,:));
    troughs_I = -troughs_I;

    length_max = length(peaks_I);
    length_min = length(troughs_I);

    total = length_min+length_max;
    x_I = zeros(1,total)+delay(A,1);
    y_I = [peaks_I,troughs_I];

    Ivalues_I = [Ivalues_I,y_I];
    Times_I = [Times_I, x_I];

  
    [peaks_S, peakIdx_S] = findpeaks(Eulerp(1,:));
    % 找到局部极小值
    [troughs_S, troughIdx_S] = findpeaks(-Eulerp(1,:));
    troughs_S = -troughs_S;

    length_max_S = length(peaks_S);
    length_min_S = length(troughs_S);

    total = length_min_S + length_max_S;
    x_S = zeros(1,total)+delay(A,1);
    y_S = [peaks_S,troughs_S];

    Ivalues_S = [Ivalues_S,y_S];
    Times_S = [Times_S, x_S];

    x_beta = zeros(1,length(betas))+delay(A,1);
    beta_x = [beta_x,x_beta];
    beta_value = [beta_value, betas];
end

figure;
subplot(2,1,1)
plot(Times_I, Ivalues_I,'*');
yline(Ic1,'r','LineWidth',2)
yline(Ic2,'g','LineWidth',2)
xlabel('time delay (days)')
ylabel('Infected group proportion (I) values')
title('Bifurcation diagram for time delay')

subplot(2,1,2)
plot(beta_x, beta_value,'*');
xlabel('time delay (days)')
ylabel('Beta changes')
title('Bifurcation diagram betas vs Ic1')
% figure;
% plot(Times_S, Ivalues_S,'*');
% xlabel('time delay (days)')
% ylabel('Susceptible group proportion (S) values')
% title('Bifurcation diagram for time delay')
