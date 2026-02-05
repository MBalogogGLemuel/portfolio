
% rng default              % pour la redproductibilite
nvars = 2;                 % nombre de variables x et y
num =2 ;                   % nombre d'elements de test
[Max,I] = max(Itest(:,indice));

d = d';
AP = X ;

formatstring = 'particleswarm reached the value %f using %d function evaluations.\n';
fun = @(x)fonction_objectif(x,d,AP,I);
options = optimoptions('particleswarm','MinNeighborsFraction',1,'InertiaRange',[0.4,0.9]);
options.SelfAdjustmentWeight = 2;
options.SocialAdjustmentWeight = 2;
options.UseVectorized = false;
options.MaxIterations = 1000;
options = optimoptions(options,'PlotFcn',[]);
 rang= [];
coordonnees_rna = [];
coordonnees_test = [];
coordonnees_PSO = [];
%%


for j=1:num   
    indice= randi([1 760],1);
    rang= [rang,indice];
    coordonnees_rna = [coordonnees_rna ,net(Itest(:,indice))];     
    coordonnees_test = [coordonnees_test ,Ttest(:,indice)];

        % Create remaining particles, randomly sampling within lb and ub
        options.SwarmSize = 60;
        numPositionsToCreate = options.SwarmSize;
        r = [rand(numPositionsToCreate,1)  rand(numPositionsToCreate,1)];
       
        Coordonnees_localisation = (net(Itest(:,indice)))';
        factor = real((-1).^(10*r)) ;
        
        valAjust = 5;

        span = (Coordonnees_localisation./valAjust);
        swarm = repmat(Coordonnees_localisation,numPositionsToCreate,1) + repmat(span,numPositionsToCreate,1).*r.*factor;
        
xmin = Coordonnees_localisation(1,1)-(Coordonnees_localisation(1,1)./valAjust);
xmax = Coordonnees_localisation(1,1)+(Coordonnees_localisation(1,1)./valAjust);
ymin = Coordonnees_localisation(1,2)-(Coordonnees_localisation(1,2)./valAjust);
ymax = Coordonnees_localisation(1,2)+(Coordonnees_localisation(1,2)./valAjust);

lb = [xmin ymin];
ub = [xmax ymax];
% lb = [0 0];
% ub = [10 10];

options.InitialSwarmMatrix = swarm; % the rest of the swarm is random
% PSO convergence characteristic

f1 = figure ;     
tic

[xn,fvaln,exitflagn,outputn] = particleswarm(fun,nvars,lb,ub,options);

fprintf(formatstring,fvaln,outputn.funccount)
indice
Indice=I
[Itest(:,indice);Ttest(:,indice)]
Coordonnees_localisation
xn
exitflagn
coordonnees_PSO=[coordonnees_PSO ,xn'];
toc

  figure(f1)   
        hold on
        grid on               
            scatter(coordonnees_test(1,:), coordonnees_test(2,:),'filled')
%             scatter(Coordonnees_localisation(1,1), Coordonnees_localisation(1,2), 70, [0 0 1],'c', 'filled')
%             scatter(swarm(:,1), swarm(:,2),'.','k')
            scatter(coordonnees_PSO(1,:), coordonnees_PSO(2,:),'s','r','filled')
%             plot([xmin xmax],[ymin ymin],'k')
%             plot([xmin xmax],[ymax ymax],'k')
%             plot([xmin xmin],[ymin ymax],'k')
%             plot([xmax xmax],[ymin ymax],'k')
                Err1 = mean(sqrt(sum(coordonnees_PSO - coordonnees_test).^2));
                title(['ERREUR MOYENNE ESTIMATION  PSO ',num2str(Err1),'meter'])
                axis([-0.1 1.1 -0.1 1.1]*10)
                hold off; 
end
%%
options = optimoptions(options,'PlotFcn',{@pswplotbestf,@pswplotranges});
[xn3,fvaln,exitflagn,outputn] = particleswarm(fun,nvars,lb,ub,options);

