function rw = randomwalk(t)

r = randn(size(t));    % 生成标准正态分布随机数
 

rw = cumsum(r);  % 累积随机数，生成随机游走路径
rw = max(rw, 0);
rw = min(rw, 1);
end
