%--------------------------------------------------------------------------
%
% DESCRIPTION: Estimates the actual position based on previously estimated
%              distances
%
%      INPUTS: X - Matrix containing the coordinates for each AP position
%              d - Estimated distances to each AP, respectively
%              real1 - x coordinate of the known position
%              real2 - y coordinate of the known position
%              min_X - minimum X coordinate of the dataset
%              max_X - maximum X coordinate of the dataset
%              min_Y - minimum Y coordinate of the dataset
%              max_Y - maximum Y coordinate of the dataset
%
%     OUTPUTS: Estimated position (x, y) 
%
%--------------------------------------------------------------------------

function [ b ] = trilateration_estimation_none( X, d, min_X, max_X, min_Y, max_Y )
	cla;
    grid on    


   
    
    %create a table with X and d
	tbl = table(X, d);
    
    %define the weights. Equals to 1 over the square of the distance
	d = d.^2;
	weights = d.^(-1);
	weights = transpose(weights);
    
    %approximated middle coordinates of dataset
	beta0 = [(max_X - min_X)/2, (max_Y - min_Y)/2];

    %define the model
	modelfun = @(b,X)(abs(b(1)-X(:,1)).^2+abs(b(2)-X(:,2)).^2).^(1/2);
    
    %fit the data to the model
	mdl = fitnlm(tbl,modelfun,beta0, 'Weights', weights);
    
    %estimated position
	b = mdl.Coefficients{1:2,{'Estimate'}};
    
   
end