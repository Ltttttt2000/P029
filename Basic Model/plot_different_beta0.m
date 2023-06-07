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


beta0s = [0.3; 0.4; 0.5; 0.6; 0.7];
eplison = 0.5;
threshold = 0.5;    
amplitudes = zeros(length(beta0s),2);
differences = zeros(length(beta0s),2);
for A = 1:length(beta0s)
    fprintf('%d\n', A);
    [t1,Eulerp,withoutpolicy,betas] = basicmodel(tspan,p0,N,threshold,beta0s(A,1), eplison);
    figure;
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
    
    susceptible = Eulerp(1,10:100);
    infected = Eulerp(2,10:100);
    
    max_S = max(susceptible);
    min_S = min(susceptible);
    amplitude_S = max_S - min_S;
    
    max_I = max(infected);
    min_I = min(infected);
    amplitude_I = max_I - min_I;
    
    amplitudes(A,1) = amplitude_S;
    amplitudes(A,2) = amplitude_I;
    fprintf("The amplitude of S: %.2f, I: %.2f\n", amplitude_S, amplitude_I);

    tol = 1e-12;
    for i = 1:length(withoutpolicy)-1
        fprintf("%d %d\n", withoutpolicy(1,i),withoutpolicy(2,i));
        diff_S = withoutpolicy(1,i+1) - withoutpolicy(1,i);
        diff_I = withoutpolicy(2,i+1) - withoutpolicy(2,i);
    
        if abs(diff_S) < tol && abs(diff_I) < tol
            fprintf("Difference: %d, %d\n", diff_S, diff_I);
            fprintf("The steady state of (S, I): %.2f, %.2f\n", withoutpolicy(1,i),withoutpolicy(2,i));
            differences(A,1) = withoutpolicy(1,i);
            differences(A,2) = withoutpolicy(2,i);
            break;
        end
    end 

%     differences(A,1) = diff_S;
%     differences(A,2) = diff_I;

    % the phase plane S-I
    subplot(2,2,2);
    plot(Eulerp(1,:),Eulerp(2,:))
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
    [t2,Eulerp2,withoutpolicy2,betas2] = basicmodel(tspan,p02,N,threshold,beta0s(A,1), eplison);
    
    p03 = [0.8; 0.2];
    [t3,Eulerp3,withoutpolicy3,betas3] = basicmodel(tspan,p03,N,threshold,beta0s(A,1), eplison);
    
    p04 = [0.2, 0.5];
    [t4,Eulerp4,withoutpolicy4,betas4] = basicmodel(tspan,p04,N,threshold,beta0s(A,1), eplison);
    
    p05 = [0.4, 0.6];
    [t5,Eulerp5,withoutpolicy5,betas5] = basicmodel(tspan,p05,N,threshold,beta0s(A,1), eplison);
    
    
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
plot(beta0s, differences(:,1));
hold on;
plot(beta0s, differences(:,2));
hold off;
title("steady state of oscillation with difference beta")
xlabel('initial beta');
ylabel('steady state')
legend('S', 'I');

saveas(gcf,"steady-beta0",'png');