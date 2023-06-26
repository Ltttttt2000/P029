## May:
5.5 meeting:
add count to delay the effect of policy.
plot the change of beta. randomwalk is more reasonable for beta changes.
使每次封锁的时间都不一样
怎么判断是否到达threshold: prevoous<threshold but next>threshold
画出f的变化？？
目前要解决的问题：放开之后也不会传染率一下子就回去
Model B, C and D is related to time threshold, after the outbreak, a longer time
will make new vaccination and treatment, new virus.

basic code:
plotSIV: 来解ode
返回withoupolicy的和有policy的进行对比
用randomwalk来决定beta的变化 odefunction(beta)

Model A


## March:
Simulating simple SIR model.

## April:
SIV: 
1. How to define the parameters? not cruel
2. use if-else? correct SIV2: change the eplison to sigmoid
plotSIV.m: plot the SIV model, use Euler to solve ode, phase plane
Change: S0, I0, paratemers in SIV2.m
How to analyse the system? basic reproduction number; Mathematical methods
nonlinear dynamics and chaos: bifurcation..useful?  No mathematical.
Simple SIV model, change eplison to multiple kinds of functions (sigmoid, randomwalk..)
