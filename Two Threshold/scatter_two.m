% for only one threshold policy (e.g. lockdown)

tspan = [0 100];   % days
S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 
h = 1;
N = (tspan(2)-tspan(1))/h;  % one day

% Ics = [
%         0.57, 0.6;      % steady 1
%         0.11, 0.2;      % 0.2-0.25 steady
%         0.11, 0.5;      % 0.25 steady
%         0.35, 0.4;      % oscillation 1
%         0.3, 0.33;      % two oscillations
%         0.4, 0.45;      % 0.2 vs 0.5 oscillation
%         0.4, 0.6;       % 0.25 vs 0.5 oscillation
%       ];
Ics = [];
Ic1 = 0.1:0.01:0.9;
Ic2 = 0.1:0.01:0.9;
for i = 1:length(Ic1)
    for j = i+1:length(Ic2)
       Ics = [Ics; [Ic1(1,i), Ic2(1,j)]];
    end
end
% Ics = [Ic1, Ic2];
% How to choose the two eplisons
eplison1 = 0.5;
eplison2 = 0.2;

beta0 = 0.5;
amplitudes = zeros(length(Ics),2);
Ivalues_I = [];
Times_I = [];
Times2_I = [];
Ivalues_S = [];
Times_S = [];
Times2_S = [];
for A = 1:length(Ics)
    [t1,Eulerp,withoutpolicy,betas] = twothreshold(tspan,p0,N, Ics(A,:),beta0,eplisons);

    susceptible = Eulerp(1,40:100);
    infected = Eulerp(2,40:100);
    
    max_S = max(susceptible);
    min_S = min(susceptible);

    max_I = max(infected);
    min_I = min(infected);

    [pks,locs] = findpeaks(susceptible);
    [pks_I,locs_I] = findpeaks(infected);

    if isempty(locs)
        amplitude_S = 0;
    else
        amplitude_S = max_S - min_S;
    end

    if isempty(locs_I)
        amplitude_I = 0;
    else
        amplitude_I = max_I - min_I;
    end
    
    amplitudes(A,1) = amplitude_S;
    amplitudes(A,2) = amplitude_I;

    [peaks_I, peakIdx_I] = findpeaks(Eulerp(2,:));
    % 找到局部极小值
    [troughs_I, troughIdx_I] = findpeaks(-Eulerp(2,:));
    troughs_I = -troughs_I;

    length_max = length(peaks_I);
    length_min = length(troughs_I);

    total = length_min+length_max;
    x_I = zeros(1,total)+ Ics(A,1);
    y_I = zeros(1,total) + Ics(A,2);
    z_I = [peaks_I,troughs_I];

    Ivalues_I = [Ivalues_I,z_I];
    Times_I = [Times_I, x_I];
    Times2_I = [Times2_I, y_I];


  
    [peaks_S, peakIdx_S] = findpeaks(Eulerp(1,:));
    % 找到局部极小值
    [troughs_S, troughIdx_S] = findpeaks(-Eulerp(1,:));
    troughs_S = -troughs_S;

    length_max_S = length(peaks_S);
    length_min_S = length(troughs_S);

    total = length_min_S + length_max_S;
    x_S = zeros(1,total)+ Ics(A,1);
    y_S = zeros(1,total) + Ics(A,2);
    z_S = [peaks_S,troughs_S];

    Ivalues_S = [Ivalues_S,z_S];
    Times_S = [Times_S, x_S];
    Times2_S = [Times2_S, y_S];

end

figure
plot3(Ics(:,1),Ics(:,2),amplitudes(:,1));
figure;
plot3(Times_I, Times2_I, Ivalues_I,'*');
xlabel('time delay (days)')
ylabel('Infected group proportion (I) values')
zlabel('ee')
title('Bifurcation diagram for time delay')
saveas(gcf,'casade-I','png')
% 
% 
% plot(Times_S, Ivalues_S,'*');
% xlabel('time delay (days)')
% ylabel('Susceptible group proportion (S) values')
% title('Bifurcation diagram for time delay')
% saveas(gcf,'casade-S','png')
% 
% saveas(gcf, 'am_2Ics','png')
