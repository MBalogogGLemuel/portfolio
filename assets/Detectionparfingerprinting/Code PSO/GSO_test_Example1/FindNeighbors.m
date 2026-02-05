% Function 4: FindNeighbors.m---------------------------------------------------
function FindNeighbors(i)
global n m A N r_d N_a Ell
n_sum = 0;
for j = 1 : n
if (j~=i)
square_sum = 0;
for k = 1 : m
square_sum = square_sum + (A(i,k)-A(j,k))^2;
end
d = sqrt(square_sum);
if (d <= r_d(i)) & (Ell(i) < Ell(j))
N(i,j) = 1;
n_sum = n_sum + 1;
end
end
N_a(i) = n_sum;
end