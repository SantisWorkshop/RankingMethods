%Santiago Rodriguez
%University of Califonia, Davis
%Last Modified: September 16, 2016

function [ MasseyWinner ] = Massey(Y,Z)
%Function to determine winner using Colley Matrix
%   Y = Candidate Matrix, input as {'A','B',...'Z'}
%   Z = Rating Matrix, m-by-n where m is # of voters and m is # of
%   candidates

%Find the dimensions of the data matrix
[m,n] = size(Z);

%Begin to create Massey matrix
M = -m*ones(n); 

%Adjust the main diagonal of Massey's matrix
for i = 1:n
   M(i,i) = (n-1)*m; 
end

%Preallocate data for score differentials
D = zeros(n,1);

%Preallocate data to count ties
Ties = zeros(n);

%Determine score differentials usin win/loss data, count ties.
for i = 1:m    
    for j = 1:n
        for k = j:n                     
            if(Z(i,j) > Z(i,k))
                s = Z(i,j) - Z(i,k);
                D(j,1) = D(j,1) + s ;      
                D(k,1) = D(k,1) - s;
                
            elseif (Z(i,j) < Z(i,k))  
                s = Z(i,j) - Z(i,k);
                D(j,1) = D(j,1) + s;      
                D(k,1) = D(k,1) - s;                         
                
            elseif (Z(i,j) == Z(i,k) && j ~= k)
              Ties(j,k) = Ties(j,k) + 2;
              Ties(k,j) = Ties(k,j) + 2;  
            end
        end
    end
end

%Add Ties to Massey matrix
M = M + Ties;

%Replace the last row of M by ones and last element in B by 0
M(n,:) = ones(1,n);
D(n,1) = 0;

%Solve the system of equations to compute the rating
MasseyRating = linsolve(M,D);

%The following line produces the entire rating of candidates.
%[~,r] = sort(MasseyRating, 'descend');

%Determine the maximum rating
[~,win] = max(MasseyRating);

%Print out winning candidate
MasseyWinner = fprintf('The winner is %s. \n',Y{1,win});

%The following outputs the entire rank vector
%fprintf('Ranking: \n');
%MasseyWinner = fprintf('%d \n', r);
end

