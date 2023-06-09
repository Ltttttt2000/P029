% for only one threshold policy (e.g. lockdown)
% steady state will change

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

% change the parameters in Ic, beta0, eplison
% the threshold of infectious people
% infection rate when there is no policy


beta0s = [0.1; 0.2; 0.3; 0.4; 0.5; 0.6; 0.7;0.8;0.9;1.0];
eplison = 0.5;
threshold = 0.5;    
amplitudes = zeros(length(beta0s),2);
differences = zeros(length(beta0s),2);
percentages = zeros(length(thresholds),1);
for A = 1:length(beta0s)
    fprintf('%d\n', A);
    [t1,Eulerp,withoutpolicy,betas,daysofpolicy,dayswithoutpolicy] = basicmodel_countdays(tspan,p0,N,threshold,beta0s(A,1), eplison);
    figure;
    name = "Beta0 = " + num2str(beta0s(A,1));
    sgtitle(name);

    subplot(2,2,1);
    plot(t1, withoutpolicy(1,:),'r')
    hold on;
    plot(t1, withoutpolicy(2,:),'b')
    hold on;
    plot(t1, Eulerp(1,:))
    hold on;
    plot(t1, Eulerp(2,:))
    legend('S origin','I origin','S','I');
    xlabel('time')
    ylabel('population')
    
    title('The population of susceptible and intected people')
    
    susceptible = Eulerp(1,50:100);
    infected = Eulerp(2,50:100);
    
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


    percentage = daysofpolicy /(daysofpolicy + dayswithoutpolicy);
    percentages(A,1) = percentage;
%     fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);

  
    % the phase plane S-I
    subplot(2,2,2);
    scatter(Eulerp(1,:),Eulerp(2,:))
    xlabel('S');
    ylabel('I');
    title('phase plane')
    
    % the beta changes verus time
    subplot(2,2,3);
    plot(t1, betas)
    xlabel('time')
    ylabel('beta')
    title('The changes of beta')
    
    % different initial state 定义多种不同的初始值

    p02 = [0.6; 0.4];
    [t2,Eulerp2,withoutpolicy2,betas2,daysofpolicy2,dayswithoutpolicy2] = basicmodel_countdays(tspan,p02,N,threshold,beta0s(A,1), eplison);
    
    p03 = [0.8; 0.2];
    [t3,Eulerp3,withoutpolicy3,betas3,daysofpolicy3,dayswithoutpolicy3] = basicmodel_countdays(tspan,p03,N,threshold,beta0s(A,1), eplison);
    
    p04 = [0.2, 0.5];
    [t4,Eulerp4,withoutpolicy4,betas4,daysofpolicy4,dayswithoutpolicy4] = basicmodel_countdays(tspan,p04,N,threshold,beta0s(A,1), eplison);
    
    p05 = [0.4, 0.6];
    [t5,Eulerp5,withoutpolicy5,betas5,daysofpolicy5,dayswithoutpolicy5] = basicmodel_countdays(tspan,p05,N,threshold,beta0s(A,1), eplison);
    
    
    subplot(2,2,4);
    hold on;
    plot(Eulerp(1,:),Eulerp(2,:));
    plot(Eulerp2(1,:),Eulerp2(2,:));
    plot(Eulerp3(1,:),Eulerp3(2,:));
    plot(Eulerp4(1,:),Eulerp4(2,:));
    plot(Eulerp5(1,:),Eulerp5(2,:));
    hold off;
    
    legend('[0.7,0.3]', '[0.6; 0.4]', '[0.8; 0.2]','[0.2, 0.5]','[0.4, 0.6]')
    xlabel('S')
    ylabel('I')
    title('Different initial [S0, I0]')
    
    txt = "beta0 " + num2str(A);
    saveas(gcf, txt, 'png');


end

figure;
plot(beta0s,amplitudes(:,1));
hold on;
plot(beta0s,amplitudes(:,2));
hold off;
title("Amplitude of oscillation with difference beta")
xlabel('initial beta');
ylabel('amplitude of oscillation')
legend('S', 'I');
saveas(gcf,"amplitude-beta0",'png');


figure;
plot(beta0s,percentages(:,1));
yline(0.5, 'r--', 'LineWidth', 2);
xlabel('initial infected rate')
ylabel('percentage of policy days')
title('Days of policy-infected rate')
saveas(gcf,'percentage-beta','png')