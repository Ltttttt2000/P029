only one threshold in ideal situation (without time delay, eplison function)

tspan = [0 100];   % days

可以改初始的S和I值
S0 = 0.7;          
I0 = 0.3;           

Change threshold  Ic = 0.2;
[t1,Eulerp,withoutpolicy,betas] = basicmodel(tspan,p0,N,Ic);

In basicmodel function:
change beta to another **fixed value** when I reach threshold **immediately**.

The natural infected rate when there is no policy beta0 = 0.5

不同的情况
S0=0.7; I0=0.3; beta0=0.5; eplison=0.5; Ic=0.2;
S0=0.7; I0=0.3; beta0=0.5; eplison=0.5; Ic=0.3;
S0=0.7; I0=0.3; beta0=0.5; eplison=0.5; Ic=0.35;
S0=0.7; I0=0.3; beta0=0.5; eplison=0.5; Ic=0.5;
S0=0.7; I0=0.3; beta0=0.5; eplison=0.5; Ic=0.7;

S0=0.7; I0=0.3; beta0=0.5; eplison=0.5; Ic=0.4;
S0=0.7; I0=0.3; beta0=0.5; eplison=0.2; Ic=0.4;
S0=0.7; I0=0.3; beta0=0.5; eplison=0.7; Ic=0.4;

S0=0.7; I0=0.3; beta0=0.7; eplison=0.5; Ic=0.4;
S0=0.7; I0=0.3; beta0=0.5; eplison=0.5; Ic=0.4;
S0=0.7; I0=0.3; beta0=0.3; eplison=0.5; Ic=0.4;

S0=0.6; I0=0.4; beta0=0.5; eplison=0.5; Ic=0.4;
S0=0.7; I0=0.3; beta0=0.5; eplison=0.5; Ic=0.4;
S0=0.8; I0=0.2; beta0=0.5; eplison=0.5; Ic=0.4;