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
thresholds = [0.1;0.2; 0.3; 0.4; 0.5; 0.6;0.7];    
amplitudes = zeros(length(0.1:0.025:0.7),2);
% for A = 1:length(thresholds)
i = 1;
for A = 0.1:0.025:0.7
    fprintf('%.2f\n', A);

    [t1,Eulerp,withoutpolicy,betas] = basicmodel(tspan,p0,N,A,beta0, eplison);

    susceptible = Eulerp(1,10:100);
    infected = Eulerp(2,10:100);
    
    max_S = max(susceptible);
    min_S = min(susceptible);
    amplitude_S = max_S - min_S;
    
    max_I = max(infected);
    min_I = min(infected);
    amplitude_I = max_I - min_I;
    
    amplitudes(i,1) = amplitude_S;
    amplitudes(i,2) = amplitude_I;
    i = i +1;
    fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);

end


figure;
plot(0.1:0.025:0.7,amplitudes(:,1));
hold on;
plot(0.1:0.025:0.7,amplitudes(:,2));
hold off;
saveas(gcf,"amplitude-threshold",'png');
