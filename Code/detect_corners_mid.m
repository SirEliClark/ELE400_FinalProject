%% Eli Clark
% ELE 400 Fall '20
% Coner Detection Algorithm
%   recieves an image, threshold, and neighborhood size
%   returns list of corner locations

function Ic = detect_corners_mid(I, t, N)
% Compute image gradients
Ix = conv2(I,[-1,0,1],'same');
Iy = conv2(I,[-1;0;1],'same');
%
Ex2 = Ix.^2;
ExEy = Ix.*Iy;
Ey2 = Iy.^2;
[m,n] = size(I);
%Ex2_p = zeros(m+2*N); Ex2_p(2*N+1:end,2*N+1:end) = Ex2(:,:);
%ExEy_p = zeros(m+2*N); ExEy_p(2*N+1:end,2*N+1:end) = ExEy(:,:);
%Ey2_p = zeros(m+2*N); Ey2_p(2*N+1:end,2*N+1:end) = Ey2(:,:);
C = zeros(2);
L = zeros(m*n,3); row = 1;
for i = (N+1):(m-N)
    for j = (N+1):(n-N)
        C(1,1) =  sum(Ex2(i-N:i+N,j-N:j+N),'all');
        C(1,2) =  sum(ExEy(i-N:i+N,j-N:j+N),'all'); C(2,1) = C(1,2);
        C(2,2) =  sum(Ey2(i-N:i+N,j-N:j+N),'all');
        l1 = eig(C);
        lambda2 = min(l1);
        if lambda2 > t 
            L(row,:) = [i j lambda2]; row = row + 1;
        end
    end
end
Lsort = sortrows(L,3);
len = size(L,1);
%figure; plot(len,Lsort(:,3));
%Ic = Lsort;
Cs = zeros(500,2); num_cs = 1;
for k = 1:len
    % Get the index of the first non-zero element
    i = find(Lsort(:,1),1);
    if isempty(i) % Exit the loop if all elements are zerp
        break
    end
    % Add location to new list
    Cs(num_cs,:) = [Lsort(i,1) Lsort(i,2)]; num_cs = num_cs + 1;
    % Loop through the rest of the list
    for x = i+1:len
        if (Lsort(i,1)+2*N >= Lsort(x,1)) && (Lsort(i,1)-2*N <= Lsort(x,1))
            if (Lsort(i,2)+2*N >= Lsort(x,2)) && (Lsort(i,2)-2*N <= Lsort(x,2))
                % Remove entries from neighborhood
                Lsort(x,:) = [0 0 0]; 
            end
        end
    end
    % Remove entry from list
    Lsort(i,:) = [0 0 0];
end

%fin = find(Cs,1,'last');
Ic = Cs(:,:);

end
