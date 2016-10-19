%Santiago Rodriguez
%University of Califonia, Davis
%Last Modified: September 16, 2016

function [ PluralityWinner ] = Plurality(Y,Z)
%Function to determine winner using Plurality
%   Y = Candidate Matrix, input as {'A','B',...'Z'}
%   Z = Rating Matrix, m-by-n where m is # of voters and m is # of
%   candidates

%Determine the dimensions of data matrix
[m,n] = size(Z);
Results = zeros(1,n);

%Count the number of times each candidate is in first place.
for i = 1:m
    for j = 1:n
        if(Z(i,j) == max(Z,[],2))
           Results(1,j) = 1 + Results(1,j);
        end
    end
end

%The following line produces the entire rating of candidates.
%[~,r] = sort(Results, 'descend');

%Declare winner
 [~,b] = max(Results);
 
 PluralityWinner = fprintf('The winner is %s. \n', Y{1,b});

%The following outputs the entire rank vector
% fprintf('Ranking: \n');
% PluralityWinner = fprintf('%d \n', r);

end

