# Application of Numerical Methods for Solutions of ODES

The objective of this homework is to explore the application of numerical methods for the solution of ODEs with emphasis on accuracy of a numerical solution.


<p align="center">
    Question 1:
</p>

Consider the following ODE:

<p align="center">
    dy(x)dx = -50(y - cos(x))
</p>


Integrate the ODE with initial conditions y(0) = 0 over the interval x 2 [0; 1] using MATLAB built-in
functions. The solution will serve as your “exact” solution.

<p align="center">
    Part A: 
</p>

   Implement explicit Euler, implicit Euler, midpoint, trapezoidal, Adams-Bashforth 2,
explicit Runge-Kutta 2 (RK2), and explicit Runge-Kutta 4 (RK4) into MATLAB solvers. Details
for the explicit RK4 method are given below and are also available on the class notes (Chapter
4). 

   Always start with a small value of h and plot the numerical solution in [0; 1] together with the MATLAB solution above. Confirm that you implemented the method correctly and get an idea
of suitable time step sizes. 

   Turn in plots of numerical solutions on the same graph together with the exact solution. For each method, produce a separate plot with the numerical solutions obtained with four reasonable choices of the time step size h as to convey the idea that the numerical solution is converging to the exact one.

<details>
<summary>Show Part A Matlab code </summary>
Matlab

```Matlab:
%% CFD Homework 2 - BRYAN ACOSTA
%% Solving ODES
clear
clc
close all
%%
% 
clear
clc
close all

x1 = linspace(0,1,30);
x2 = linspace(0,1,40);
x3 = linspace(0,1,50);
x4 = linspace(0,1,75);
x5 = linspace(0,1,150);
x6 = linspace(0,1,400);


diffequation=@(x,y) -50*(y - cos(x));

% EXACT ODE VS EXPLICIT EULER
figure(1)
plot(x6,exact_solution(diffequation,x6))
hold on
title('EXACT ODE VS EXPLICIT EULER')
plot(x2,Explicit_Euler(diffequation,x2),'g')
hold on
plot(x3,Explicit_Euler(diffequation,x3),'k')
hold on
plot(x4,Explicit_Euler(diffequation,x4),'r')
legend('Exact Solution','40','50','75')

% EXACT ODE VS IMPLICIT EULER
figure(2)
plot(x6,exact_solution(diffequation,x6))
hold on
title('EXACT ODE VS IMPLICIT EULER')
plot(x2,Implicit_Euler(diffequation,x2),'g')
hold on
plot(x3,Implicit_Euler(diffequation,x3),'k')
hold on
plot(x4,Implicit_Euler(diffequation,x4),'r')
hold on
plot(x6,Implicit_Euler(diffequation,x6),'m')
legend('Exact Solution','40','50','75','400')
%%
% EXACT ODE VS MIDPOINT METHOD
figure(3)
plot(x6,exact_solution(diffequation,x6))
hold on
title('EXACT ODE VS MIDPOINT METHOD')
plot(x2,Midpoint(diffequation,x2),'g')
hold on
plot(x3,Midpoint(diffequation,x3),'k')
hold on
plot(x6,Midpoint(diffequation,x6),'m')
legend('Exact Solution','40','50','400')
%%
% EXACT ODE VS TRAPEZOIDAL METHOD
figure(4)
plot(x6,exact_solution(diffequation,x6))
hold on
title('EXACT ODE VS TRAPEZOIDAL METHOD')
plot(x1,0.5.*trapezoidal(diffequation,x1),'g')
hold on
plot(x2,0.5.*trapezoidal(diffequation,x2),'k')
hold on
plot(x3,0.5.*trapezoidal(diffequation,x3),'r')
hold on
plot(x6,0.5.*trapezoidal(diffequation,x6),'m')
legend('Exact Solution','30','40','50','400')
%%
% EXACT ODE VS ADAMS-BASHFORTH2 METHOD
figure(5)
plot(x6,exact_solution(diffequation,x6))
hold on
title('EXACT ODE VS ADAMS-BASHFORTH2 METHOD')
plot(x3,AdamsB2(diffequation,x3),'g')
hold on
plot(x4,AdamsB2(diffequation,x4),'k')
hold on
plot(x6,AdamsB2(diffequation,x6),'r')
legend('Exact Solution','50','75','400')
%%
% EXACT ODE VS RUNGE-KUTTA 2 METHOD
figure(6)
plot(x6,exact_solution(diffequation,x6))
hold on
title('EXACT ODE VS RUNGE-KUTTA 2 METHOD')
plot(x1,RK2(diffequation,x1),'g')
hold on
plot(x2,RK2(diffequation,x2),'k')
hold on
plot(x6,RK2(diffequation,x6),'r')
legend('Exact Solution','30','40','400')

% EXACT ODE VS RUNGE-KUTTA 4 METHOD
figure(7)
plot(x6,exact_solution(diffequation,x6))
hold on
title('EXACT ODE VS RUNGE-KUTTA 4 METHOD')
plot(x1,RK4(diffequation,x1),'g')
hold on
plot(x2,RK4(diffequation,x2),'k')
hold on
plot(x3,RK4(diffequation,x3),'r')
hold on
plot(x6,RK4(diffequation,x6),'m')
legend('Exact Solution','30','40','50','400')
%%
function [y] = exact_solution(diffeq, xspan)
    [~, y] = ode45(diffeq,xspan, 0);
    
end
function [output] = Explicit_Euler(diffeq, xspan)
    jump = xspan(2);
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           output(i+1) = output(i) + jump*diffeq(xspan(i), output(i));
    end
end
function [output] =Implicit_Euler(diffeq, xspan)
    jump = xspan(2);
    misc = xspan.*0;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           misc(i+1) = misc(i) + diffeq(xspan(i), misc(i))*jump;
           output(i+1) = output(i)+ jump* diffeq(xspan(i+1), misc(i+1));
    end
end
function [output] =Midpoint(diffeq, xspan)
    jump = xspan(2);
    halfjump = jump/2;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           output(i+1) = output(i) + jump*diffeq(xspan(i)+halfjump,output(i)+halfjump*diffeq(xspan(i),output(i)));
    end
end
function [output] =trapezoidal(diffeq, xspan)
    jump = xspan(2);
    halfjump = jump/2;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           output(i+1) = output(i)+ halfjump*(diffeq(xspan(i), output(i))+ diffeq(xspan(i+1), output(i+1)));
    end 
end
function [output] =AdamsB2(diffeq, xspan)
    jump = xspan(2);
    output = xspan.*0;
    for i = 1: (length(xspan)-2)
           output(i+2) = output(i+1) + 0.5*jump*(3*diffeq(xspan(i+1), output(i+1))-diffeq(xspan(i),output(i)));
    end
end
function [output] = RK2(diffeq, xspan)
    jump = xspan(2);
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           input1 = xspan(i)+ 0.5*jump;
           input2 = output(i)+(0.5*jump*diffeq(xspan(i),output(i)));
           output(i+1) = output(i) + jump*diffeq(input1,input2);
    end
end
function [output] = RK4(diffeq, xspan)
    jump = xspan(2);
    halfjump = jump/2;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           input1 = diffeq(xspan(i),output(i));
           input2 = diffeq(xspan(i)+ halfjump,output(i)+halfjump*input1);
           input3 = diffeq(xspan(i)+ halfjump,output(i)+halfjump*input2);
           input4 = diffeq(xspan(i)+ jump,output(i)+jump*input3);
           output(i+1) = output(i) + (1/6)*jump*(input1+input2+input3+input4);
    end
end
    
```
</details>

<p align="center">
    Part B: 
</p>

   For each method, advance the solution until x = 1. Repeat with various step sizes h
and compute the difference between the numerical solution and the “exact” solution. Call this
difference the (global) “error” for a given step size, e(h).
Plot the absolute value of the error jej (y-axis) as a function of 1=h (x-axis), where h is the step
   size. Use a log-log plot and report the error for all numerical methods considered.
<details>
<summary>Show Part B Matlab code </summary>
Matlab

```Matlab:
    
%% CFD Homework 2 - BRYAN ACOSTA
%% Solving ODES
clear
clc
close all
%%
% 
clear
clc
close all

x1 = linspace(0,1,30);
x2 = linspace(0,1,40);
x3 = linspace(0,1,50);
x4 = linspace(0,1,75);
x5 = linspace(0,1,150);
x6 = linspace(0,1,400);

diffequation=@(x,y) -50*(y - cos(x));
%%
% EXACT ODE VS EXPLICIT EULER
figure(1)
title('EXACT ODE VS EXPLICIT EULER')
exactval = exact_solution(diffequation,x2);
estval = Explicit_Euler(diffequation,x2);
input1 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x3);
estval = Explicit_Euler(diffequation,x3);
input2 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x4);
estval = Explicit_Euler(diffequation,x4);
input3 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x6);
estval = Explicit_Euler(diffequation,x6);
input4 = abs(exactval(end) - estval(end));

loglog([length(x2),length(x3),length(x4),length(x6)],[input1,input2,input3,input4],'v-')
grid on
title('EXACT ODE VS EXPLICIT EULER')
%%

% EXACT ODE VS IMPLICIT EULER
figure(2)
exactval = exact_solution(diffequation,x2);
estval = Implicit_Euler(diffequation,x2);
input1 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x3);
estval = Implicit_Euler(diffequation,x3);
input2 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x4);
estval = Implicit_Euler(diffequation,x4);
input3 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x6);
estval = Implicit_Euler(diffequation,x6);
input4 = abs(exactval(end) - estval(end));

loglog([length(x2),length(x3),length(x4),length(x6)],[input1,input2,input3,input4],'v-')
grid on
title('EXACT ODE VS IMPLICIT EULER ERROR')

%%

% EXACT ODE VS MIDPOINT METHOD
figure(3)
exactval = exact_solution(diffequation,x3);
estval = Midpoint(diffequation,x3);
input1 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x4);
estval = Midpoint(diffequation,x4);
input2 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x5);
estval = Midpoint(diffequation,x5);
input3 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x6);
estval = Midpoint(diffequation,x6);
input4 = abs(exactval(end) - estval(end));

loglog([length(x3),length(x4),length(x5),length(x6)],[input1,input2,input3,input4],'v-')
grid on
title('EXACT ODE VS MIDPOINT METHOD ERROR')
%%
% EXACT ODE VS TRAPEZOIDAL METHOD
figure(4)
exactval = exact_solution(diffequation,x1);
estval = trapezoidal(diffequation,x1);
input1 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x2);
estval = trapezoidal(diffequation,x2);
input2 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x3);
estval = trapezoidal(diffequation,x3);
input3 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x6);
estval = trapezoidal(diffequation,x6);
input4 = abs(exactval(end) - estval(end));

loglog([length(x1),length(x2),length(x3),length(x6)],[input1,input2,input3,input4],'v-')
grid on
title('EXACT ODE VS TRAPEZOIDAL METHOD ERROR')

%%
% EXACT ODE VS ADAMS-BASHFORTH2 METHOD
figure(5)

exactval = exact_solution(diffequation,x4);
estval = AdamsB2(diffequation,x4);
input1 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x5);
estval = AdamsB2(diffequation,x5);
input3 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x6);
estval = AdamsB2(diffequation,x6);
input4 = abs(exactval(end) - estval(end));

loglog([length(x4),length(x5),length(x6)],[input1,input3,input4],'v-')
grid on

title('EXACT ODE VS ADAMS-BASHFORTH2 METHOD ERROR')
%%
% EXACT ODE VS RUNGE-KUTTA 2 METHOD
figure(6)

exactval = exact_solution(diffequation,x1);
estval = RK2(diffequation,x1);
input1 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x2);
estval = RK2(diffequation,x2);
input3 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x6);
estval = RK2(diffequation,x6);
input4 = abs(exactval(end) - estval(end));

loglog([length(x1),length(x2),length(x6)],[input1,input3,input4],'v-')
grid on
title('EXACT ODE VS RUNGE-KUTTA 2 METHOD ERROR')
%%
% EXACT ODE VS RUNGE-KUTTA 4 METHOD
figure(7)

exactval = exact_solution(diffequation,x1);
estval = RK4(diffequation,x1);
input1 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x2);
estval = RK4(diffequation,x2);
input2 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x3);
estval = RK4(diffequation,x3);
input3 = abs(exactval(end) - estval(end));

exactval = exact_solution(diffequation,x6);
estval = RK4(diffequation,x6);
input4 = abs(exactval(end) - estval(end));

loglog([length(x1),length(x2),length(x6)],[input1,input3,input4],'v-')
grid on
title('EXACT ODE VS RUNGE-KUTTA 4 METHOD ERROR')
%%
function [y] = exact_solution(diffeq, xspan)
    [~, y] = ode45(diffeq,xspan, 0);
    
end
function [output] = Explicit_Euler(diffeq, xspan)
    jump = xspan(2);
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           output(i+1) = output(i) + jump*diffeq(xspan(i), output(i));
    end
end
function [output] =Implicit_Euler(diffeq, xspan)
    jump = xspan(2);
    misc = xspan.*0;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           misc(i+1) = misc(i) + diffeq(xspan(i), misc(i))*jump;
           output(i+1) = output(i)+ jump* diffeq(xspan(i+1), misc(i+1));
    end
end
function [output] =Midpoint(diffeq, xspan)
    jump = xspan(2);
    halfjump = jump/2;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           output(i+1) = output(i) + jump*diffeq(xspan(i)+halfjump,output(i)+halfjump*diffeq(xspan(i),output(i)));
    end
end
function [output] =trapezoidal(diffeq, xspan)
    jump = xspan(2);
    halfjump = jump/2;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           output(i+1) = output(i)+ halfjump*(diffeq(xspan(i), output(i))+ diffeq(xspan(i+1), output(i+1)));
    end 
end
function [output] =AdamsB2(diffeq, xspan)
    jump = xspan(2);
    output = xspan.*0;
    for i = 1: (length(xspan)-2)
           output(i+2) = output(i+1) + 0.5*jump*(3*diffeq(xspan(i+1), output(i+1))-diffeq(xspan(i),output(i)));
    end
end
function [output] = RK2(diffeq, xspan)
    jump = xspan(2);
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           input1 = xspan(i)+ 0.5*jump;
           input2 = output(i)+(0.5*jump*diffeq(xspan(i),output(i)));
           output(i+1) = output(i) + jump*diffeq(input1,input2);
    end
end
function [output] = RK4(diffeq, xspan)
    jump = xspan(2);
    halfjump = jump/2;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           input1 = diffeq(xspan(i),output(i));
           input2 = diffeq(xspan(i)+ halfjump,output(i)+halfjump*input1);
           input3 = diffeq(xspan(i)+ halfjump,output(i)+halfjump*input2);
           input4 = diffeq(xspan(i)+ jump,output(i)+jump*input3);
           output(i+1) = output(i) + (1/6)*jump*(input1+input2+input3+input4);
    end
end
function [output] = grabsize(xspan)
    output = xspan.*1;
    jump = 1/length(xspan);
    for i = 1 : length(xspan)
        output(i) = jump*i;
        
    end
end
    
```
</details>
