figure;

[t,h] = ode45(@SIR,[0 300],[0.01 0.99]);    
% @SIR function, [time slot] [%of initial infected population % of initial susceptible population]

% Plot S, I with t
plot(t,h(:,1),'r', 'Linewidth', 2, 'MarkerSize', 8);
hold on;

plot(t,h(:,2),'b', 'Linewidth', 2, 'MarkerSize', 8);
plot(t,1-h(:,1)-h(:,2),'g', 'Linewidth', 2, 'MarkerSize', 8)


legend('% I','% S','%R','FontSize',20);
title('SIR','FontSize',20)
xlabel('time','FontSize',20)
ylabel('proportion', 'FontSize',20)

% 相位图
% figure;
% plot(h(:,2),h(:,1))
% title('phase plane')
% xlabel('S')
% ylabel('I')