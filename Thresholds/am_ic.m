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
% eplison = 0.6; % Simulate the two policy implemented together. eplison2 = 0.2, eplisonq = 0.5
thresholds = [0.1;0.2; 0.3; 0.4; 0.5; 0.6;0.7]; 
steps = 0.01;
amplitudes = zeros(length(0.1:steps:0.7),2);
percentages = zeros(length(0.1:steps:0.7),1);
% for A = 1:length(thresholds)
i = 1;
for A = 0.1:steps:0.7
    fprintf('%.2f\n', A);

    [t1,Eulerp,withoutpolicy,betas,daysofpolicy,dayswithoutpolicy] = basicmodel_countdays(tspan,p0,N,A,beta0, eplison);

    susceptible = Eulerp(1,80:100);
    infected = Eulerp(2,80:100);
    
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
    
    amplitudes(i,1) = round(amplitude_S,3);
    amplitudes(i,2) = round(amplitude_I,3);

    fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);

    percentage = daysofpolicy /(daysofpolicy + dayswithoutpolicy);
    percentages(i,1) = percentage;

    i = i +1;
end


figure;
plot(0.1:steps:0.7,amplitudes(:,1));
hold on;
plot(0.1:steps:0.7,amplitudes(:,2));
hold off;
xlabel('threshold Ic')
ylabel('amplitude')
title('amplitude-threshold')
set(gcf,'position',[100,50,500,300])
saveas(gcf,"amplitude-threshold-details",'png');

figure;
plot(0.1:steps:0.7,percentages(:,1));
yline(0.5, 'r--', 'LineWidth', 2);
xlabel('threshold Ic')
ylabel('percentage of policy days')
title('Days of policy-threshold')
set(gcf,'position',[100,50,500,200])
saveas(gcf,'percentage-details','png')
