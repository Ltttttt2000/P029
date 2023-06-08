only one threshold in ideal situation (without time delay, eplison function)
解释每个代码都是干什么的

> Natural.m 画出没有政策干预情况下的steady state
>
> Naturalmodel.m 在beta是0.5时的解ode的过程
>
> plot_only_one.m 只画Ic=0.5, beta0=0.5, eplison=0.5时的震荡，求出amplitude
>
> basicmodel.m 解ode的Euler
>
> odefunction.m S和I变化的方程（输入beta）
>
> plotSIV.m
>
> plot_batch.m 画出所有情况下的图
>
> plot_different_Ic.m
>
> plot_different_beta0.m
>
> plot_different_eplison.m 

tspan = [0 100];   % days

可以改初始的S和I值
S0 = 0.7;          
I0 = 0.3;           

Change threshold  Ic = 0.2;
[t1,Eulerp,withoutpolicy,betas] = basicmodel(tspan,p0,N,Ic);

In basicmodel function:
change beta to another **fixed value** when I reach threshold **immediately**.

The natural infected rate when there is no policy beta0 = 0.5