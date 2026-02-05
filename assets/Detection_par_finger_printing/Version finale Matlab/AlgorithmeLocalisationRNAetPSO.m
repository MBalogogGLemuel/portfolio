close all;
clear all;
clc;

%% Etape 1: Point de releve connu 
position = [3 ; 4.5];                   % Position d'un point de mesure connu a l'avance (donnees en conditions relles)

%% Etape 2: Niveau de puissacne recus Recieve Signal Strength RSS 

                                        % Donnees des niveaux de puissance
                                        % recu RSSI (donnees relles) [rssi1 , rssi2 , rssi3 , rssi4]
RSS = [-53.6   %from AP1
-53.2   %from AP2
-55     %from AP3
-65.2   %from AP4
];

%% Etape 3: Localisation des points d'encrage Anchors Point

X = [0, 0; 0,10; 10,0; 10,10];          %  position des emetteurs wifi, [x1,y1 ; x2,y2 ; x3,y3 ; x4,y4 ]

%% Eape 4: Distance AP-Point a localiser

d = Friss(RSS);             %  estimation des distance du point...chaque emetteur wifi

%% Eape 4: Representation du point localise 

Coordonnees_localisation = trilateration_estimation( X, d', 3 , 4.5, 0, 10, 0, 10 ) % trilateration a partir de chaque emetteur wifi...
                                                            %(CoordAP,DistancesAP-Point,min_X, max_X, min_Y, max_Y)

%% Creation d'une base de donnees des Positions RSSI et position estimees

BaseDonnees = [];
nbre = 50;

for i=1:800;
      rssi = [ randi([-60 -30],1)  %from AP1
               randi([-60 -30],1)  %from AP2
               randi([-60 -30],1)  %from AP3
               randi([-60 -30],1)  %from AP4      
             ] ;
      dist = Friss(rssi); 
      coordonnees = trilateration_estimation_none( X, dist', 0, 10, 0, 10 );
      bd = [rssi'  coordonnees'];
      BaseDonnees = [BaseDonnees,bd'];
end
    figure('Name','Distribution des points de mesures dans un local ','NumberTitle','off');
grid on;
hold on;
    %plot the estimated position (blue)
	scatter(BaseDonnees(5,1:50), BaseDonnees(6,1:50), 20, [0 0 1], 'filled');
    plot(X(:,1),X(:,2),'ko','MarkerSize',8,'lineWidth',2,'MarkerFaceColor','k');
    legend('Position de mesures','Position des emetteurs wifi')
    axis([-0.1 1.1 -0.1 1.1]*10)
hold off
        %% Sauvegarde de la base de donnee
% save("C:\Users\BALO\Desktop\Memoire ENSPD\matlab\donnees\BD",'BaseDonnees')
        
        %% Traitement des donnees
            %Charger la BD si necessaire
% load('C:\Users\BALO\Desktop\Memoire ENSPD\matlab\donnees\BD.mat')
            
            %% Scinder la Base de donnees en 02 groupes, les entrees et les sorties 
Inputs=BaseDonnees(1:4,:);
Targets=BaseDonnees(5:end,:);
    
            %% Scindage des donnees tests et des donnees d'entrainements
            
            %Donnees d'entrainements            
Itrain=Inputs(:,1:(nbre));
Ttrain=Targets(:,1:(nbre));
            
            %Donnees tests        
Itest=Inputs(:,(nbre+1):end);
Ttest=Targets(:,(nbre+1):end);
        
 
% save("C:\Users\BALO\Desktop\Memoire ENSPD\matlab\donnees\Itrain",'Itrain')
% save("C:\Users\BALO\Desktop\Memoire ENSPD\matlab\donnees\Ttrain",'Ttrain')
% save("C:\Users\BALO\Desktop\Memoire ENSPD\matlab\donnees\Itest",'Itest')
% save("C:\Users\BALO\Desktop\Memoire ENSPD\matlab\donnees\Ttest",'Ttest')

            %%
            
% rna
% save ("C:\Users\BALO\Desktop\Memoire ENSPD\matlab\donnees\rna\net", 'net')
% load 'C:\Users\BALO\Desktop\Memoire ENSPD\matlab\donnees\rna\net.mat'
load('net.mat')
            
            %%
num =4 ; %nombre de points de simulation



%%%%%%%%%%%%Donnees de test a large echelle%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
coordonnees_rna = [];
coordonnees_test = [];
for j=1:num    
    indice= randi([1 760],1);
    coordonnees_rna = [coordonnees_rna ,net(Itest(:,indice))];     
    coordonnees_test = [coordonnees_test ,Ttest(:,indice)];
end
            figure('Name','Localisation par RNA avec 50 points de mesures' ,'NumberTitle','off');
grid on;
hold on;
    %plot the estimated position (blue)
	scatter(coordonnees_rna(1,:) , coordonnees_rna(2,:),[],'b');
    scatter(coordonnees_test(1,:), coordonnees_test(2,:),[],'r');
    %plot(X(:,1),X(:,2),'ko','MarkerSize',8,'lineWidth',2,'MarkerFaceColor','k');
    %legend('Position de mesures','Position des emetteurs wifi')
    Err = mean(sqrt(sum((coordonnees_rna - coordonnees_test).^2)));
    title(['ERREUR MOYENNE ESTIMATION ~ MSE ',num2str(Err),'meter'])
    axis([-0.1 1.1 -0.1 1.1]*10)
hold off



%%
%Simulation par PSO
PSO



            