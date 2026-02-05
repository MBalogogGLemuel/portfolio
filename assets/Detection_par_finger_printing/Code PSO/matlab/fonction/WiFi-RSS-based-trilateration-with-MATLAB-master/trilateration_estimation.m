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

function [ b ] = trilateration_estimation( X, d, real1, real2, min_X, max_X, min_Y, max_Y )
	cla;
    
    %define the axis
	axis([min_X max_X min_Y max_Y]);
    grid on;
	hold on;
    
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
    
    
    %plot the estimated position (blue)
	scatter(b(1), b(2), 70, [0 0 1], 'filled');
    
    plot(X(:,1),X(:,2),'ko','MarkerSize',8,'lineWidth',2,'MarkerFaceColor','k');
	
    %plot the real position (red)
    scatter(real1, real2, 70, [1 0 0], 'filled');
    
        legend('Position estimee','Position des emetteurs wifi','Position relle')
        
    % Compute the Root Mean Squred Error
    mobileLoc = [real1 real2];
    Err = mean(sqrt(sum((b-mobileLoc).^2)));
    title(['ERREUR MOYENNE ESTIMATION ~ MSE ',num2str(Err),'meter'])
    axis([-0.1 1.1 -0.1 1.1]*10)
	hold off;
end