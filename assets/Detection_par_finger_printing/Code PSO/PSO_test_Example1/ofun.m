function f=ofun(x)
% objective function (minimization)
d =[4.756513769245194 4.542435384938036 5.588416397522384 18.083760985197670];
AP = [0 0;0 10;10 0;10 10];
of=(d(:)- sqrt(abs(x(1)-AP(:,1)).^2 + abs(x(2)-AP(:,2)).^2)).^2;
% constraints (all constraints must be converted into <=0 type)
% if there is no constraints then comments all c0 lines below
% c0=[];
% c0(1)=x(1)+x(2)+x(3)-5; % <=0 type constraints
% c0(2)=x(1)^2+2*x(2)-x(3); % <=0 type constraints
% % defining penalty for each constraint
% for i=1:length(c0)
% if c0(i)>0
% c(i)=1;
% else
% c(i)=0;
% end
% end
% penalty=10000; % penalty on each constraint violation
f=sum(of)'; % fitness function
end