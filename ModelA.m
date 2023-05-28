function [t,r,withoutpolicy,betachange] = ModelA(tspan,yI,N)

% S:x(1) I:x(2) 
beta0 = 0.5;         % infection rate

% two threshold for border control and lockdown policy
Ic1 = 0.3;      % for lockdown policy
Ic2 = 0.4;      % for border control

f1 = 1;         % intensity of lockdown
f2 = 1;         % intensity of border control

% Forward Euler method
tI = tspan(1);
tF = tspan(2);
h = (tF - tI)/N;

d = numel(yI);  % return the size of yI
y = zeros(d, N+1);
y(:,1) = yI;  % 2*1 matrix y(1,1)=S, y(2,1)=I
without(:,1) = yI;
withoutpolicy(:,1) = yI;
t=linspace(tI,tF,N+1)'; 
r(:,1) = yI;
t = [0];
betachange = [0.5];

count1 = 0; 
count2 = 0;


fprintf('The initial population: S:%.2f, I:%.2f\n', y(1,1),y(2,1));
for k = 1:N   %time h:day

    if y(2,1) < Ic1
        beta = 0.5;
        count1 = 0;  % If the infected people lower than threshold, the government will not implement the policy.
        count2 = 0;
    elseif y(2,1) >=Ic1 && y(2,1)<Ic2 && count1 <5
        beta = 0.5;
        count1 = count1 + 1;
        count2 = 0;     % reset count2
    elseif y(2,1) >=Ic1 && y(2,1)<Ic2 && count1 >=5
%         eplison = sigmoid(count-10);
        eplison1 = randomwalk(count1 -5);  % 更合理
%         eplison1 = sigmoid(count1-5);
        beta = (1-f1*eplison1)*beta0; 
        count1 = count1 + 1;  % 表示执行计划开始的时间 eplision越大 beta越小
        count2 = 0;
    elseif y(2,1) >= Ic2 && count2 <5
        eplison1 = randomwalk(count1 -5);  % 更合理
%         eplison1 = sigmoid(count1-5);
        beta = (1-f1*eplison1)*beta0;
        count2 = count2 + 1;
    elseif y(2,1) >=Ic2 && count2>=5
        eplison1 = randomwalk(count1 -5);  % 更合理
%         eplison1 = sigmoid(count1-5);
%         eplison2 = sigmoid(count2-10);
        eplison2 = randomwalk(count2);
        beta = (1-f1*eplison1)*(1-f2*eplison2)*beta0;  
        count2 = count2 + 1;
    end

    without = without(:,1)+functionA(without(:,1),beta0);
    y(:,1) = y(:,1)+functionA(y(:,1),beta);

    fprintf('Time: %d S0: %.2f I0: %.2f beta0: %.2f S:%.2f I:%.2f beta:%.2f count1:%d count2:%d\n', ...
        k,without(1,1),without(2,1),beta0,y(1,1),y(2,1),beta,count1,count2);
    yv = [y(1,1);y(2,1)];

    withoutpolicy = [withoutpolicy without];
    r = [r yv];
    t = [t k];
    betachange = [betachange beta];
%     fprintf('beta: %f count: %d\n', beta,count);

end

fprintf('==================================================\n');
end