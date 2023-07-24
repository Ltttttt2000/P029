% for only one threshold policy (e.g. lockdown)

tspan = [0 100];   % days
S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 
h = 1;
N = (tspan(2)-tspan(1))/h;  % one day

Ics = [
        0.57, 0.6;      % steady 1
        0.11, 0.5;      % 0.25 steady
        0.11, 0.2;      % 0.2-0.25 steady

        0.35, 0.4;      % 0.25 vs 0.5 oscillation 
        0.3, 0.33;      % two oscillations
        0.4, 0.45;      % 0.2 vs 0.5 oscillation

        0.45, 0.47;     % 0.25 vs 0.5 --> 0.2 vs 0.5
        0.33, 0.35;     % 2 oscillation --> 0.25 vs 0.5
        0.1,  0.11;     % 0.2 vs 0.25
      ];

% How to choose the two eplisons
eplison1 = 0.5;
eplison2 = 0.2;

beta0 = 0.5;
amplitudes = zeros(length(Ics),2);

for A = 1:length(Ics)
    [t1,Eulerp,withoutpolicy,betas] = twothreshold2(tspan,p0,N, Ics(A,:),beta0,eplisons,0);

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
    

    figure;
    Ic1 = Ics(A,1);
    Ic2 = Ics(A,2);
    name = "Ic1=" + num2str(Ic1)+",Ic2="+ num2str(Ic2);
    sgtitle(name);
    subplot(2,1,1)
    plot(t1, withoutpolicy(1,:),'r')
    hold on;
    plot(t1, withoutpolicy(2,:),'b')
    hold on;
    plot(t1, Eulerp(1,:))
    hold on;
    plot(t1, Eulerp(2,:))
    yline(Ic1,'k','LineWidth',2);
    yline(Ic2,'g', 'LineWidth',2);
    legend('S origin','I origin','S','I');
    xlabel('time')
    ylabel('population')
    
    
    % the beta changes verus time
    subplot(2,1,2);
    plot(t1, betas,'*')
    xlabel('time')
    ylabel('beta')
    title('The changes of beta')
    figname = "Ex"+ num2str(A);
%     saveas(gcf, figname,'png')
    fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);


end


% figure;
% plot3(Ics(:,1),Ics(:,2),amplitudes(:,1),'*');


