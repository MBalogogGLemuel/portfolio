% Function 2: UpdateLuciferin.m-------------------------------------------------
function UpdateLuciferin
global n A J Ell gamma ro
for i = 1 : n
x = A(i,1); y = A(i,2);
% The Matlab ’Peaks’ function is used here. Please replace it with
% the multimodal function for which peaks are sought
J(i,:) = 3*(1-x)^2*exp(-(x^2) - (y+1)^2) ...
- 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2) ...
- 1/3*exp(-(x+1)^2 - y^2);
Ell(i,:) = (1-ro)*Ell(i,:) + gamma*J(i,:);
end