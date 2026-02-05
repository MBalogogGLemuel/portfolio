% Function 5: FindProbabilities.m----------------------------------------
function FindProbabilities(i)
global n N Ell pb
Ell_sum = 0;
for j = 1 : n
Ell_sum = Ell_sum + N(i,j)*(Ell(j) - Ell(i));
end
if (Ell_sum == 0)
pb(i,:) = zeros(1,n);
else
for j = 1 : n
pb(i,j) = (N(i,j)*(Ell(j)-Ell(i)))/Ell_sum;
end
end