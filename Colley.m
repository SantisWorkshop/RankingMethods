%Santiago Rodriguez
%University of Califonia, Davis
%Last Modified: September 16, 2016

function [ ColleyWinner ] = Colley(Y,Z)
%Function to determine winner using Colley Matrix
%   Y = Candidate Matrix, input as {'A','B',...'Z'}
%   Z = Rating Matrix, m-by-n where m is # of voters and m is # of
%   candidates

%Find the dimensions of the data matrix
[m,n] = size(Z);

%Begin to create Colley Matrix
C = -m*ones(n); 

%Convert Massey Matrix into Colley Matrix
for i = 1:n
   C(i,i) = (n-1)*m + 2; 
end

%Preallocate memory for win/loss of ratings
TotalWins = zeros(1,n);
TotalLoss = zeros(1,n);

%Set matrix to count ties
Ties = zeros(n);

%Count wins,losses,ties
for i = 1:m    
    for j = 1:n
        for k = j:n         
            
            if(Z(i,j) > Z(i,k))                
                TotalWins(:,j) = TotalWins(:,j) + 1;
                TotalLoss(:,k) = TotalLoss(:,k) + 1;         
                
            elseif (Z(i,j) < Z(i,k))                
                TotalLoss(:,j) = TotalLoss(:,j) + 1;
                TotalWins(:,k) = TotalWins(:,k) + 1;               
                
            elseif (Z(i,j) == Z(i,k) && j ~= k)
              Ties(j,k) = Ties(j,k) + 2;
              Ties(k,j) = Ties(k,j) + 2;  
            end
        end
    end
end

%Add ties to Colley Matrix
C = C + Ties;

%Allocate memory for b vector
b = zeros(n,1);

%Generate vector b
for j = 1:n
    b(j,:) = 1 + .5*(TotalWins(:,j) - TotalLoss(:,j));
end

%Solve the system of equations to compute the ratings.
ColleyRating = linsolve(C,b); 

%The following line produces the entire rating of candidates.
%[~,r] = sort(ColleyRating, 'descend');

%Determine the maximum rating
[~,win] = max(ColleyRating);

%Print out winning candidate
ColleyWinner = fprintf('The winner is %s. \n',Y{1,win});

end

