tspan = [0 100];   % days
S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 
h = 1;
N = (tspan(2)-tspan(1))/h;  % one day

delay = [0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16];
Ivalues_I = [];
Times_I = [];

Ivalues_S = [];
Times_S = [];
for A = 1:length(delay)
    [t1,Eulerp,withoutpolicy,betas] = timedelay(tspan,p0,N,delay(A,1));
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
end

figure;
plot(Times_I, Ivalues_I,'*');
xlabel('time delay (days)')
ylabel('Infected group proportion (I) values')
yline(0.56,'r', 'LineWidth',2)
set(gcf,'position',[100,50,400,200]);
title('Bifurcation diagram for time delay')
% saveas(gcf,'casade-I','png')

figure;
plot(Times_S, Ivalues_S,'*');
xlabel('time delay (days)')
ylabel('Susceptible group proportion (S) values')
title('Bifurcation diagram for time delay')
% saveas(gcf,'casade-S','png')
yline(0.38,'r', 'LineWidth',2)
set(gcf,'position',[100,50,400,200]);
% saveas(gcf,'casede','png')