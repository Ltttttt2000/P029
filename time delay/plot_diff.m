% for only one policy (lockdown)

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


delay = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15];
amplitudes = zeros(length(delay),2);
for A = 1:length(delay)
    [t1,Eulerp,withoutpolicy,betas] = timedelay(tspan,p0,N,delay(A,1));

    figure;
    subplot(2,2,1);
    plot(t1, withoutpolicy(1,:),'r')
    hold on;
    plot(t1, withoutpolicy(2,:),'b')
    hold on;
    plot(t1, Eulerp(1,:))
    hold on;
    plot(t1, Eulerp(2,:))
    legend('S_origin','I_origin','S','I');
    xlabel('time')
    ylabel('population')
    title('SIV, when reach threshold, implement policy')


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
    subplot(2,2,4);
    p02 = [0.6; 0.4];
    [t2,Eulerp2,withoutpolicy2,betas2] = timedelay(tspan,p02,N,delay(A,1));
    p03 = [0.2; 0.2];
    [t3,Eulerp3,withoutpolicy3,betas3] = timedelay(tspan,p03,N,delay(A,1));
    plot(Eulerp(1,:),Eulerp(2,:))
    hold on;
    plot(Eulerp2(1,:),Eulerp2(2,:))
    hold on;
    plot(Eulerp3(1,:),Eulerp3(2,:))
    xlabel('S')
    ylabel('I')

    txt = "timedelay " + num2str(A);
    saveas(gcf,txt,'png');
end

figure;
plot(delay,amplitudes(:,1));
hold on;
plot(delay,amplitudes(:,2));
hold off;
xlabel("Days delay")
ylabel('oscillation amplitude')
legend('S','I')
saveas(gcf,"amplitude-timedelay",'png');