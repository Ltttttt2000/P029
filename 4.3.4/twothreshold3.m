% This combine SIV ode function and Euler together 
% change the beta 
% Ic2是由S-I决定的

function [t,r,withoutpolicy,betachange,days] = twothreshold3(tspan,yI,N, Ics,beta0,eplisons,delay)

% S:x(1) I:x(2) 

Ic1 = Ics(1,1);
Ic2 = Ics(1,2);
eplison1 = eplisons(1,1);
eplison2 = eplisons(2,1);
% change threshold

f = 1;            % intensity of measurements


% Forward Euler method
tI = tspan(1);
tF = tspan(2);
h = (tF - tI)/N;

d = numel(yI);  % return the size of yI
y = zeros(d, N+1);
y(:,1) = yI;  % 2*1 matrix y(1,1)=S, y(2,1)=I

% To plot the situation when there is no policy
without(:,1) = yI;
withoutpolicy(:,1) = yI;

t=linspace(tI,tF,N+1)'; 

r(:,1) = yI;      % return the ode solution

t = 0;
betachange = beta0;
days1 = 0;   % 都不实行
days2 = 0;      % 只policy1
days3 = 0;      % 两种都policy2
days4 = 0;

count1 = 0;
count2 = 0;
for k = 1:N   %time h:day
    SminsI = y(1,1)-y(2,1);
    I = y(2,1);

    if I < Ic1 % Ic1没实行的话不会有oscillation，不用考绿Ic2的实行
        beta = 0.5;
        count1 = 0;
        count2 = 0;
        days1 =  days1 + 1;
    elseif I >= Ic1 && SminsI < Ic2 && count1 < delay  % 都不实行
        beta = 0.5;
        count1 = count1 + 1;
        count2 = 0;
        days1 =  days1 + 1;
    elseif I >= Ic1 && SminsI < Ic2 && count1 >= delay  % 只实行1
        beta = (1-f*eplison1)*beta0; 
        count1 = count1 + 1;
        count2 = 0;       
        days2 =  days2 + 1;      
    elseif I >= Ic1 && SminsI >= Ic2 && count2 < delay  % only 1
        beta = (1-f*eplison1)*beta0; 
        count1 = count1 + 1;
        count2 = count2 + 1;
        days2 = days2 + 1;
    elseif I >= Ic1 && SminsI >= Ic2 && count2 >= delay
        beta = (1-f*eplison1)*(1-f*eplison2)*beta0;
        count1 = count1 + 1;
        count2 = count2 + 1;
        days3 = days3 + 1;
    end

%     if I < Ic1
%         beta = 0.5;
%         days1 =  days1 + 1;
%     elseif I >=Ic1 && SminsI < Ic2
%         beta = (1-f*eplison1)*beta0; 
%         days2 =  days2 + 1;
%     elseif SminsI >=Ic2
%         beta = (1-f*eplison1)*(1-f*eplison2)*beta0;
%         days3 =  days3 + 1;
%     end

%     if I < Ic1 && SminsI < Ic2
%         beta = 0.5;
%         count1 = 0;
%         count2 = 0;
%         days1 =  days1 + 1;
%     elseif I >= Ic1 && SminsI < Ic2 && count1 < delay
%         beta = 0.5;
%         count1 = count1 + 1;
%         count2 = 0;
%         days1 =  days1 + 1;
%     elseif I >= Ic1 && SminsI < Ic2 && count1 >= delay
%         beta = (1-f*eplison1)*beta0; 
%         count1 = count1 + 1;
%         count2 = 0;       
%         days2 =  days2 + 1;      
%     elseif I < Ic1 && SminsI >= Ic2 && count2 < delay
%         beta = 0.5;
%         count2 = count2 + 1;
%         count1 = 0;
%         days1 =  days1 + 1;
%     elseif I < Ic1 && SminsI >= Ic2 && count2 >= delay
%         beta = (1-f*eplison2)*beta0; 
%         count2 = count2 + 1;
%         count1 = 0;       
%         days3 =  days3 + 1;
% 
%     elseif I >= Ic1 && SminsI >= Ic2 && count1 < delay && count2 < delay
%         beta = 0.5;
%         count1 = count1 + 1;
%         count2 = count2 + 1;
%         days1 =  days1 + 1;
%     elseif I >= Ic1 && SminsI >= Ic2 && count1 >= delay && count2 < delay
%         beta = (1-f*eplison1)*beta0; 
%         count1 = count1 + 1;
%         count2 = count2 + 1;
%         days2 = days2 + 1;
%     elseif I >= Ic1 && SminsI >= Ic2 && count1 >= delay && count2 >= delay
%         beta = (1-f*eplison1)*(1-f*eplison2)*beta0;
%         count1 = count1 + 1;
%         count2 = count2 + 1;
%         days4 = days4 + 1;
%     elseif I >= Ic1 && SminsI >= Ic2 && count1 < delay && count2 >= delay
%         beta = (1-f*eplison2)*beta0;
%         count1 = count1 + 1;
%         count2 = count2 + 1;
%         days3 = days3 + 1;
%     end
    without = without(:,1)+odefunction(without(:,1),beta0);
    y(:,1) = y(:,1)+odefunction(y(:,1),beta);

%     fprintf('Day %d S0: %.2f I0: %.2f initial infected rate: %.2f S:%.2f I:%.2f infected rate:%.2f\n', ...
%         k,without(1,1),without(2,1),beta0,y(1,1),y(2,1),beta);
%     
    yv = [y(1,1);y(2,1)];

    withoutpolicy = [withoutpolicy without];
    r = [r yv];
    t = [t k];
    betachange = [betachange beta];
    
%     fprintf('beta: %f count: %d\n', beta,count);

end
days = [days1, days2, days3, days4];
% fprintf('==================================================\n');
end