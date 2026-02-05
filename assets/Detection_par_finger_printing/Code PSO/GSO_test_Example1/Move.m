% Function 7: Move.m------------------------------------
function Move(i,j)
global A m step1 Ell bound
if (j~=0) & (Ell(i) < Ell(j))
temp(i,:) = A(i,:) + step1*Path(i,j);
flag = 0;
for k = 1 : m
if (temp(i,k) < -bound) | (temp(i,k) > bound)
flag = 1;
break;
end
end
if (flag == 0)
A(i,:) = temp(i,:);
end
end