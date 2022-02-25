
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