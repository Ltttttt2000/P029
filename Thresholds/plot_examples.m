% for only one threshold policy (e.g. lockdown)


S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 

% Euler methods
% Eulerp: the vector[s,i] with threshold policy
% withoutpolicy: vector[s,i] without policy
% betas: the beta changes when threshold policy
Ic = 0.5;
beta0 = 0.7;
eplison = 0.5;

% Day
tspan = [0 100];   % days
h = 1;
N = (tspan(2)-tspan(1))/h;  % one day

% Week
% tspan = [0 140];
% h = 7;
% N = (tspan(2)-tspan(1))/h;  % one day
[t1,Eulerp,withoutpolicy,betas,daysofpolicy, dayswithoutpolicy] = basicmodel_countdays(tspan,p0,N,Ic, beta0,eplison);


susceptible = Eulerp(1,40:100);
infected = Eulerp(2,40:100);

max_S = max(susceptible);
min_S = min(susceptible);
amplitude_S = max_S - min_S;

max_I = max(infected);
min_I = min(infected);
amplitude_I = max_I - min_I;

[pks,locs] = findpeaks(susceptible);
[pks_I,locs_I] = findpeaks(infected);

if isempty(locs)
    amplitude_S = 0;
end

if isempty(locs_I)
    amplitude_I = 0;
end


fprintf("%d,%d\n", daysofpolicy, dayswithoutpolicy);
percentage = daysofpolicy /(daysofpolicy + dayswithoutpolicy);

[Pxx,f] = periodogram(susceptible);


figure;
% name = "Ic=" + num2str(Ic);
name = "Beta0= "+num2str(beta0);
% name = "Eplison="+num2str(eplison);
sgtitle(name)

subplot(1,2,1)
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

subplot(1,2,2);
scatter(Eulerp(1,:),Eulerp(2,:))
xlabel('S');
ylabel('I');
yline(Ic,'LineWidth',2,'Label','Ic')
title('phase plane')
set(gcf,'position',[500,100,500,200])

