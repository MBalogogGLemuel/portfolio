% Function 3: Act.m---------------------------------------------------
function Act
global n r_s r_d N N_a beta n_t
N(:,:) = zeros(n,n);
N_a(:,:)= zeros(n,1);
for i = 1 : n
FindNeighbors(i);
FindProbabilities(i);
Leader(i) = SelectAgent(i);
end
for i = 1 : n
Move(i,Leader(i));
r_d(i) = max(0, min(r_s,r_d(i) + beta*(n_t-N_a(i))));
end