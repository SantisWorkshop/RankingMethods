%Santiago Rodriguez
%University of Califonia, Davis
%Last Modified: September 16, 2016

function [ BordaWinner ] = BordaCount(Y,Z)

[m,n] = size(Z);
R = zeros(n);

%Count the placement of candidates by the voters

while Z ~= -ones(m,n)
    for i = 1 : m
        for j = 1:n
        [~, indexOfMax] = max(Z(i, :));
        Z(i, indexOfMax) = -1;
        R(j,indexOfMax) = 1 + R(j,indexOfMax);
        end
    end
end



%Allocate data for Borda points
BordaPts = zeros(1,n);
for i = 1:n
   BordaPts(1,i) = n - i;
end
BordaMatrix = BordaPts * R;


%The following line produces the entire rating of candidates.
%[~,r] = sort(BordaMatrix, 'descend');

%Compute the winner based on the given value of 'Winner'
[~,b] = max(BordaMatrix);
BordaWinner = fprintf('The winner is %s. \n', Y{1,b});

%The following outputs the entire rank vector
% fprintf('Ranking: \n');
% BordaWinner = fprintf('%d \n', r);


end

