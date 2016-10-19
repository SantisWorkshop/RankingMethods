%Santiago Rodriguez
%University of Califonia, Davis
%Last Modified: September 16, 2016

function [ PageRankWin ] = PageRank(Y,Z)
%Function to determine winner using PageRank Method
%   Y = Candidate Matrix, input as {'A','B',...'Z'}
%   Z = Rating Matrix, m-by-n where m is # of voters and m is # of
%   candidates

%Find the dimensions of the data matrix
[m,n] = size(Z);

%set p for stochasticity
p = .85;

%Allocate data for team votes
X =  zeros(n);

%Create matrix of all ones to convert matrix to stochastic
N = ones(n);

%Determine winners and give them a vote
for i = 1:m
    for j = 1:n
        for k = j:n
            if(Z(i,j) > Z(i,k))
               X(k,j) = 1 + X(k,j);                
            elseif (Z(i,j) < Z(i,k))
               X(j,k) = 1 + X(j,k);
            end
        end
    end
end

%Ensure stochasticity
for j = 1:n
    if (X(j,:) == zeros(1,n))
        X(j,:) = 1/n*ones(1,n);
    end
end

%Find the total number of votes
s = sum(X,2);

%Convert x into a stochasitc matrix
x = zeros(n);

for j = 1:n
   x(j,:) = (1/s(j,:))*X(j,:);
end

%Matrix that ensures irreducibility
P = p*x + ((1- p)/n)*N;

%Compute Eigenvalues of P
[~,~,W] = eig(P);

%Get corresponding eigenvector
%eig, places the dominant eigenvalue first, so we take use the
%corresponding eigenvector.
Pagerank = W(:,1);

%Normalize
Pagerank = Pagerank/sum(Pagerank);

%The following line produces the entire rating of candidates.
%[~,r] = sort(Pagerank, 'descend');

%Determine the maximum rating
%[~,win] = max(Pagerank);

%Print out winning candidate
PageRankWin = fprintf('The winner is %s. \n',Y{1,win});

%The following outputs the entire rank vector
%fprintf('Ranking: \n');
%PageRankWin = fprintf('%d \n', r);

end

