tspan = [0 100];   % days
S0 = 0.7;           % initial susceptible population 
I0 = 0.3;           % initial intected proportion

p0 = [S0; I0];      % vector of ode 
h = 1;
N = (tspan(2)-tspan(1))/h;  % one day

delay = 8;
xvalues = [];
yvalues = [];
[t1,Eulerp,withoutpolicy,betas] = timedelay(tspan,p0,N,delay);
[peaks, peakIdx] = findpeaks(Eulerp(2,:));

% 找到局部极小值
[troughs, troughIdx] = findpeaks(Eulerp(2,:));

length_max = length(peaks);
length_min = length(troughs);

x = zeros(1,length_min+length_max)+delay;
y = [peaks,troughs];
figure;
scatter(x, y);