# Application of Numerical Methods for Solutions of ODES

The objective of this homework is to explore the application of numerical methods for the solution of ODEs with emphasis on accuracy of a numerical solution.



# Question 1:


Consider the following ODE:

<p align="center">
    dy(x)dx = -50(y - cos(x))
</p>


Integrate the ODE with initial conditions y(0) = 0 over the interval x 2 [0; 1] using MATLAB built-in
functions. The solution will serve as your “exact” solution.


# Q1 Part 1: 


   Implement explicit Euler, implicit Euler, midpoint, trapezoidal, Adams-Bashforth 2,
explicit Runge-Kutta 2 (RK2), and explicit Runge-Kutta 4 (RK4) into MATLAB solvers. Details
for the explicit RK4 method are given below and are also available on the class notes (Chapter
4). 

   Always start with a small value of h and plot the numerical solution in [0; 1] together with the MATLAB solution above. Confirm that you implemented the method correctly and get an idea
of suitable time step sizes. 

   Turn in plots of numerical solutions on the same graph together with the exact solution. For each method, produce a separate plot with the numerical solutions obtained with four reasonable choices of the time step size h as to convey the idea that the numerical solution is converging to the exact one.

<details>
<summary>Show Q1 Part 1 Matlab code </summary>
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


# Q1 Part 2: 


   For each method, advance the solution until x = 1. Repeat with various step sizes h
and compute the difference between the numerical solution and the “exact” solution. Call this
difference the (global) “error” for a given step size, e(h).
Plot the absolute value of the error jej (y-axis) as a function of 1=h (x-axis), where h is the step
   size. Use a log-log plot and report the error for all numerical methods considered.
<details>
<summary>Show Part Q1 part 1 Matlab code </summary>
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


# Q1 Part 3 & 4: 


   For each method, fit a function E = Ch^Alpha to the (h; jej) pairs and confirm that Alpha is close to the value you expect given the rate of convergence of a specific method from the book and
class notes.

   For each method and a choice of time step h, produce a measure of the “work” (i.e. the
“effort”) required to integrate the IVP from t = 0 to t = 1. One sensible manner of measuring
“work” is to count how many times the function f(t; y) is evaluated as the method steps from
t = 0 to t = 1. Modify the MATLAB functions to accomplish this objective (e.g. you may
do this by updating a global counter every time the function is called) and call this number of
function evaluations M.

   Produce another log-log plot, whereby you plot e vs.M for all numerical methods and time step
sizes considered. In other words, your plot will show e vs. M as h decreases (and M increases)
for all methods.

   What can you conclude by comparing the curves obtained with the various methods?
   
   A point worth considering. When you implement an implicit method, evaluations of f(t; y)
are required to solve for the implicit equation that has yn+1 as a solution. So, to an extent,
the function responsible for solving the implicit equation (e.g. the MATLAB function fsolve)
decides how many function evaluations are required at each time step in order to achieve a
user-prescribed tolerance.

<details>
<summary>Show Part Q1 part 1 Matlab code </summary>
Matlab

```Matlab:
%% CFD Homework 2 - BRYAN ACOSTA


%%
% 
clear
clc
close all


%% Calculating Work & Alpha
x1 = linspace(0,1,30);
x2 = linspace(0,1,32);
x3 = linspace(0,1,34);
x4 = linspace(0,1,36);
x5 = linspace(0,1,38);
x6 = linspace(0,1,40);

h = [32 , 34, 36, 40];
global counter 

diffequation=@(x,y) -50*(y - cos(x));
%%
% EXACT ODE VS EXPLICIT EULER
countervec1 = (linspace(1,4,4)).*0;
error1 = (linspace(1,4,4)).*0;

[exactval,~] = exact_solution(diffequation,x2);
[estval,counter] = Explicit_Euler(x2);
input = abs(exactval(end) - estval(end));
countervec1(1) = counter;
error1(1) = input;

[exactval,~] = exact_solution(diffequation,x3);
[estval,counter] = Explicit_Euler(x3);
input = abs(exactval(end) - estval(end));
countervec1(2) = counter;
error1(2) = input;

[eactval,~] = exact_solution(diffequation,x4);
[estval,counter] = Explicit_Euler(x4);
input = abs(exactval(end) - estval(end));
countervec1(3) = counter;
error1(3) = input;

[exactval,~] = exact_solution(diffequation,x6);
[estval,counter] = Explicit_Euler(x6);
input = abs(exactval(end) - estval(end));
countervec1(4) = counter;
error1(4) = input;

%%
% EXACT ODE VS IMPLICIT EULER
countervec2 = (linspace(1,4,4)).*0;
error2 = (linspace(1,4,4)).*0;

[exactval,~] = exact_solution(diffequation,x2);
[estval,counter] = Implicit_Euler(x2);
input = abs(exactval(end) - estval(end));
countervec2(1) = counter;
error2(1) = input;

[exactval,~] = exact_solution(diffequation,x3);
[estval,counter] = Implicit_Euler(x3);
input = abs(exactval(end) - estval(end));
countervec2(2) = counter;
error2(2) = input;

[exactval,~] = exact_solution(diffequation,x4);
[estval,counter] = Implicit_Euler(x4);
input = abs(exactval(end) - estval(end));
countervec2(3) = counter;
error2(3) = input;

[exactval,~] = exact_solution(diffequation,x6);
[estval,counter] = Implicit_Euler(x6);
input = abs(exactval(end) - estval(end));
countervec2(4) = counter;
error2(4) = input;
%%

% EXACT ODE VS MIDPOINT METHOD

countervec3 = (linspace(1,4,4)).*0;
error3 = (linspace(1,4,4)).*0;

[exactval,~] = exact_solution(diffequation,x2);
[estval,counter] = Midpoint(x2);
input = abs(exactval(end) - estval(end));
countervec3(1) = counter;
error3(1) = input;

[exactval,~] = exact_solution(diffequation,x3);
[estval,counter] = Midpoint(x3);
input = abs(exactval(end) - estval(end));
countervec3(2) = counter;
error3(2) = input;

[exactval,~] = exact_solution(diffequation,x4);
[estval,counter] = Midpoint(x4);
input = abs(exactval(end) - estval(end));
countervec3(3) = counter;
error3(3) = input;

[exactval,~] = exact_solution(diffequation,x6);
[estval,counter] = Midpoint(x6);
input = abs(exactval(end) - estval(end));
countervec3(4) = counter;
error3(4) = input;

%%
% EXACT ODE VS TRAPEZOIDAL METHOD

countervec4 = (linspace(1,4,4)).*0;
error4 = (linspace(1,4,4)).*0;

[exactval,~] = exact_solution(diffequation,x2);
[estval,counter] = trapezoidal(x2);
input = abs(exactval(end) - estval(end));
countervec4(1) = counter;
error4(1) = input;

[exactval,~] = exact_solution(diffequation,x3);
[estval,counter] = trapezoidal(x3);
input = abs(exactval(end) - estval(end));
countervec4(2) = counter;
error4(2) = input;

[exactval,~] = exact_solution(diffequation,x4);
[estval,counter] = trapezoidal(x4);
input = abs(exactval(end) - estval(end));
countervec4(3) = counter;
error4(3) = input;

[exactval,~] = exact_solution(diffequation,x6);
[estval,counter] = trapezoidal(x6);
input = abs(exactval(end) - estval(end));
countervec4(4) = counter;
error4(4) = input;

%%
% EXACT ODE VS ADAMS-BASHFORTH2 METHOD
countervec5 = (linspace(1,4,4)).*0;
error5 = (linspace(1,4,4)).*0;

[exactval,~] = exact_solution(diffequation,x2);
[estval,counter] = AdamsB2(x2);
input = abs(exactval(end) - estval(end));
countervec5(1) = counter;
error5(1) = input;

[exactval,~] = exact_solution(diffequation,x3);
[estval,counter] =AdamsB2(x3);
input = abs(exactval(end) - estval(end));
countervec5(2) = counter;
error5(2) = input;

[exactval,~] = exact_solution(diffequation,x4);
[estval,counter] = AdamsB2(x4);
input = abs(exactval(end) - estval(end));
countervec5(3) = counter;
error5(3) = input;

[exactval,~] = exact_solution(diffequation,x6);
[estval,counter] = AdamsB2(x6);
input = abs(exactval(end) - estval(end));
countervec5(4) = counter;
error5(4) = input;

%%
% EXACT ODE VS RUNGE-KUTTA 2 METHOD
countervec6 = (linspace(1,4,4)).*0;
error6 = (linspace(1,4,4)).*0;

[exactval,~] = exact_solution(diffequation,x2);
[estval,counter] = RK2(x2);
input = abs(exactval(end) - estval(end));
countervec6(1) = counter;
error6(1) = input;

[exactval,~] = exact_solution(diffequation,x3);
[estval,counter] = RK2(x3);
input = abs(exactval(end) - estval(end));
countervec6(2) = counter;
error6(2) = input;

[exactval,~] = exact_solution(diffequation,x4);
[estval,counter] = RK2(x4);
input = abs(exactval(end) - estval(end));
countervec6(3) = counter;
error6(3) = input;

[exactval,~] = exact_solution(diffequation,x6);
[estval,counter] = RK2(x6);
input = abs(exactval(end) - estval(end));
countervec6(4) = counter;
error6(4) = input;



%%
% EXACT ODE VS RUNGE-KUTTA 4 METHOD

countervec7 = (linspace(1,4,4)).*0;
error7 = (linspace(1,4,4)).*0;

[exactval,~] = exact_solution(diffequation,x2);
[estval,counter] = RK4(x2);
input = abs(exactval(end) - estval(end));
countervec7(1) = counter;
error7(1) = input;

[exactval,~] = exact_solution(diffequation,x3);
[estval,counter] = RK4(x3);
input = abs(exactval(end) - estval(end));
countervec7(2) = counter;
error7(2) = input;

[exactval,~] = exact_solution(diffequation,x4);
[estval,counter] = RK4(x4);
input = abs(exactval(end) - estval(end));
countervec7(3) = counter;
error7(3) = input;

[exactval,~] = exact_solution(diffequation,x6);
[estval,counter] = RK4(x6);
input = abs(exactval(end) - estval(end));
countervec7(4) = counter;
error7(4) = input;


%%

% counting power
figure(1)
plot(error1,countervec1) %blue
hold on
plot(error2,countervec2) %red
hold on
plot(error3,countervec3) %yellow
hold on
plot(error4,countervec4) %purple
hold on
plot(error5,countervec5) %green
hold on
plot(error6,countervec6) %blue
hold on
plot(error7,countervec7) %darkred
legend('expl euler','imp euler','midpoint','trap','AMb2','RK2','Rk5')
xlim([-0.2 1.7])
ylim([0 160])

%%
%{
This graph conveys the idea that the higher the h, the faster the the graph
converges onto the exact solution. This shows that even though the solution
requires a lot more work to be done for a calculation, in the end it is
worth it because of how much faster it finishes. It also visualizes how
much faster the more advanced methods like RK4 are than Explicit Euler.
%}

%%
num = 30;
for i = 2:5
    vec = linspace(0,1,num);
    powers = getpower(vec);
    
    fprintf('For size of num')
    disp(num)
    
    fprintf('Power with Eplicit Euler')
    disp(powers(i))
    fprintf('Power with Implicit Euler')
    disp(powers(i))
    fprintf('Power with Midpoint')
    disp(powers(i))
    fprintf('Power with Trapezoid Euler')
    disp(powers(i))
    fprintf('Power with Adams Bashforth Method')
    disp(powers(i))
    fprintf('Power with RK2')
    disp(powers(i))
    fprintf('Power with RK5')
    disp(powers(i))
    num = num + 2;
end

%%
%For the Explicit Euler Method:
%Alpha = -0.7989
%For the Implicit Euler Method 
%Alpha = -1.029
% For Midpoint.
% ALPHA = -7.047
% Trapezoid Method.
%ALPHA = 0.04238
%AdamsB2 Method
%ALPHA = 21.99 
%RK2 Method
%ALPHA = -7.047 
%RK4 Method
%Alpha =  -1.172
[xData, yData] = prepareCurveData( h, error1 );
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.0036911293190958 -0.798914698260166];
[fitresult, gof] = fit( xData, yData, ft, opts );
figure( 'Name', 'untitled fit 1' );
h_1 = plot( fitresult, xData, yData );
legend( h_1, 'error1 vs. h', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
xlabel( 'h', 'Interpreter', 'none' );
ylabel( 'error1', 'Interpreter', 'none' );
grid on

%For the Implicit Euler Method 
%Alpha = -1.029
[xData, yData] = prepareCurveData( h, error2 );
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [58.2972804846504 -1.03036117616061];
[fitresult, gof] = fit( xData, yData, ft, opts );
figure( 'Name', 'untitled fit 1' );
h_1 = plot( fitresult, xData, yData );
legend( h_1, 'error2 vs. h', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
xlabel( 'h', 'Interpreter', 'none' );
ylabel( 'error2', 'Interpreter', 'none' );
grid on



% For Midpoint.
% ALPHA = -7.047
[xData, yData] = prepareCurveData( h, error3 );
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [16071999.4877197 -7.04748723927692];
[fitresult, gof] = fit( xData, yData, ft, opts );
figure( 'Name', 'untitled fit 1' );
h_1 = plot( fitresult, xData, yData );
legend( h_1, 'error3 vs. h', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
xlabel( 'h', 'Interpreter', 'none' );
ylabel( 'error3', 'Interpreter', 'none' );
grid on



% Trapezoid Method.
%ALPHA = 0.04238
[xData, yData] = prepareCurveData( h, error4 );
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.48239321237515 0.0447063789106446];
[fitresult, gof] = fit( xData, yData, ft, opts );
figure( 'Name', 'untitled fit 1' );
h_1 = plot( fitresult, xData, yData );
legend( h_1, 'error4 vs. h', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
xlabel( 'h', 'Interpreter', 'none' );
ylabel( 'error4', 'Interpreter', 'none' );
grid on

%AdamsB2 Method
%ALPHA = 21.99 
[xData, yData] = prepareCurveData( h, error5 );
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [2.43119566493717e+44 -24.3901265610395];
[fitresult, gof] = fit( xData, yData, ft, opts );
figure( 'Name', 'untitled fit 1' );
h_1 = plot( fitresult, xData, yData );
legend( h_1, 'error5 vs. h', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
xlabel( 'h', 'Interpreter', 'none' );
ylabel( 'error5', 'Interpreter', 'none' );
grid on

%RK2 Method
%ALPHA = -7.047 
[xData, yData] = prepareCurveData( h, error6 );
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [16071999.4877197 -7.04748723927692];
[fitresult, gof] = fit( xData, yData, ft, opts );
figure( 'Name', 'untitled fit 1' );
h_1 = plot( fitresult, xData, yData );
legend( h_1, 'error6 vs. h', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
xlabel( 'h', 'Interpreter', 'none' );
ylabel( 'error6', 'Interpreter', 'none' );
grid on

%RK4 Method
%Alpha =  -1.172
[xData, yData] = prepareCurveData( h, error7 );
ft = fittype( 'power1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [1.10625849955209 -1.17162968027378];
[fitresult, gof] = fit( xData, yData, ft, opts );
figure( 'Name', 'untitled fit 1' );
h_1 = plot( fitresult, xData, yData );
legend( h_1, 'error7 vs. h', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
xlabel( 'h', 'Interpreter', 'none' );
ylabel( 'error7', 'Interpreter', 'none' );
grid on

%{
For the Explicit Euler Method: Alpha = -0.7989
For the Implicit Euler Method: Alpha = -1.029
For Midpoint: ALPHA = -7.047
Trapezoid Method: ALPHA = 0.04238
AdamsB2 Method: ALPHA = 21.99 
RK2 Method: ALPHA = -7.047 
RK4 Method: Alpha =  -1.172
%}


%%
function [y,counter] = exact_solution(diffeq, xspan)
    [~, y] = ode45(diffeq,xspan, 0);
    counter = 1;
    
end
function [output,counter] = solve_equation(xval, yval, counter)
    counter = counter +1;
    diffequation=@(x,y) -50*(y - cos(x));
    output = diffequation(xval,yval);
end
function [output,counter] = Explicit_Euler(xspan)
    counter = 0;
    jump = xspan(2);
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           [soln, counter] = solve_equation(xspan(i), output(i),counter);
           output(i+1) = output(i) + jump*soln;
    end
end
function [output,counter] =Implicit_Euler(xspan)
    counter = 0;
    jump = xspan(2);
    misc = xspan.*0;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           [soln, counter] =  solve_equation(xspan(i), misc(i),counter);
           misc(i+1) = misc(i) + soln*jump;
           [soln2, counter] = solve_equation(xspan(i+1), misc(i+1),counter);
           output(i+1) = output(i)+ jump*soln2 ;
    end
end
function [output,counter] =Midpoint(xspan)
    counter = 0;
    jump = xspan(2);
    halfjump = jump/2;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
        [soln, counter] =solve_equation(xspan(i),output(i),counter);
        [soln, counter] = solve_equation(xspan(i)+halfjump,output(i)+halfjump*soln,counter);
           output(i+1) = output(i) + jump*soln;
    end
end
function [output,counter] =trapezoidal(xspan)
    counter = 0;
    jump = xspan(2);
    halfjump = jump/2;
    output = xspan.*0;
    
    for i = 1: (length(xspan)-1)
            [soln, counter] = solve_equation(xspan(i), output(i),counter);
            [soln2, counter] = solve_equation(xspan(i+1), output(i+1),counter);
           output(i+1) = output(i)+ halfjump*(soln+soln2 );
    end 
end
function [output,counter] =AdamsB2( xspan)
    counter = 0;
    jump = xspan(2);
    output = xspan.*0;
    for i = 1: (length(xspan)-2)
        [misc,counter] = solve_equation(xspan(i+1), output(i+1),counter);
        [misc2,counter]= solve_equation(xspan(i),output(i),counter);
           output(i+2) = output(i+1) + 0.5*jump*(3*misc-misc2);
    end
end

function [output,counter] = RK2( xspan)
    counter = 0;
    jump = xspan(2);
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           input1 = xspan(i)+ 0.5*jump;
           [misc,counter] = solve_equation(xspan(i),output(i),counter);
           input2 = output(i)+(0.5*jump*misc);
           [misc,counter] = solve_equation(input1,input2,counter);
           output(i+1) = output(i) + jump*misc;
    end
end
function [output,counter] = RK4(xspan)
    counter = 0;
    jump = xspan(2);
    halfjump = jump/2;
    output = xspan.*0;
    for i = 1: (length(xspan)-1)
           [input1,counter] = solve_equation(xspan(i),output(i),counter);
           [input2,counter] = solve_equation(xspan(i)+ halfjump,output(i)+halfjump*input1,counter);
           [input3,counter] = solve_equation(xspan(i)+ halfjump,output(i)+halfjump*input2,counter);
           [input4,counter] = solve_equation(xspan(i)+ jump,output(i)+jump*input3,counter);
           output(i+1) = output(i) + jump*((1/6)*input1+(2/6)*input2+(2/6)*input3+(1/6)*input4);
    end
end
function [countervec] = getpower(xspan)
    diffequation=@(x,y) -50*(y - cos(x));
    countervec = (linspace(1,8,8)).*0;
    [~,counter] = exact_solution(diffequation,xspan);
    countervec(1) = counter;
    [~,counter] = Explicit_Euler(xspan);
    countervec(2) = counter;
    [~,counter] = Implicit_Euler(xspan);
    countervec(3) = counter;
    [~,counter] = Midpoint(xspan);
    countervec(4) = counter;
    [~,counter] = trapezoidal(xspan);
    countervec(5) = counter;
    [~,counter] = AdamsB2(xspan);
    countervec(6) = counter;
    [~,counter] = RK2(xspan); %just need M
    countervec(7) = counter;
    [~,counter] = RK4(xspan);
    countervec(8) = counter;
end
function lambda = lambda(x,y)
    lambda  = -2*(1-cos(pi*x/(y+1)));
    return
end
    
```
</details>

# Question 2: 

Consider the following N * N tridiagonal matrix TN:
TN = 
[-2   1       0 ]
[ 1  ... ...  0 ]
[    ... ...  1 ]
[ 0       1  -2 ]

where N >= 1.
   Compute the eigenvalues of the matrix for N = 10 and confirm that they are
lamda(i) = -2(1- cos(pi*i/(N + 1)) at i = 1, ... ,N (3)
Next, plot max abs(lambda), i.e. the maximum absolute value of all eigenvalues of TN versus N for N = 1,..., 20. 
   Comment on the behavior of max abs(lambda) as N changes. Reconciliate your finding with the expression for lamda provided above in Eq. (3).
Turn in plots that support your answers and explanations.

<details>
<summary>Show Part Q2 Matlab code </summary>
Matlab
    
```Matlab:

%% Question 2:

eig = zeros(length(i),1);
for i = 1:20
    eig(i) = max(abs(lambda((1:i)',i)));
end
plot(1:20, eig)
title('Maximum Eigenvalues')
ylabel('Max Eig Value')
xlabel('N')

eigen_values = (lambda((1:10)',10))';
disp(eigen_values)

%{
The amount of Eigen Values is linear to the amount of N the function has,
making this plot. This graph shows that how the eigenvalues approach 4 as N
goes to infinity. 
%}
    
```
</details>
