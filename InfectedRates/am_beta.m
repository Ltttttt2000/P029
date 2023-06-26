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

% change the parameters in Ic, beta0, eplison
% the threshold of infectious people
% infection rate when there is no policy


beta0 = 0.5;
eplison = 0.5;
threshold = 0.5;
steps = 0.01;
amplitudes = zeros(length(0.1:steps:1.0),2);
percentages = zeros(length(0.1:steps:1.0),1);
% for A = 1:length(thresholds)
i = 1;
for A = 0.1:steps:1.0
    fprintf('%.2f\n', A);

    [t1,Eulerp,withoutpolicy,betas,daysofpolicy,dayswithoutpolicy] = basicmodel_countdays(tspan,p0,N,threshold,A, eplison);

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
    
    amplitudes(i,1) = amplitude_S;
    amplitudes(i,2) = amplitude_I;

    percentage = daysofpolicy /(daysofpolicy + dayswithoutpolicy);
    percentages(i,1) = percentage;
    i = i +1;
    fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);

end


figure;
plot(0.1:steps:1.0,amplitudes(:,1));
hold on;
plot(0.1:steps:1.0,amplitudes(:,2));
hold off;
saveas(gcf,"amplitude-beta0-details",'png');

figure;
plot(0.1:steps:1.0,percentages(:,1));
yline(0.5, 'r--', 'LineWidth', 2);
xlabel('Infected rate beta0')
ylabel('percentage of policy days')
title('Days of policy-beta0')
saveas(gcf,'percentage-beta-details','png')