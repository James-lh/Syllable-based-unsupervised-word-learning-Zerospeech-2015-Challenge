function [ngrams,freqs] = getngrams(seq,maxorder,alphsize)

if nargin <2 maxorder = 3;end

%alphsize = max(seq);

if(alphsize > 2*length(unique(seq)))
    %warning('sparse alphabet in seq');
end

if(maxorder > 1)
    T = sparse(alphsize^(maxorder+1),1);
    
    for k = 1:length(seq)-maxorder+1
        seqloc = seq(k:k+maxorder-1);
        v = getloc(seqloc,alphsize);
        T(v) = T(v)+1;
    end
    
    ngrams = find(T > 0);
    T = T(T > 0);
    freqs = full(T);
else
    
    T = zeros(alphsize,1);
    for k = 1:length(seq)
        if(~isnan(seq(k)))
        T(seq(k)) =  T(seq(k))+1;
        end
    end
    ngrams = find(T > 0);
    freqs = T(T > 0);
    
end


% [T,I] = sort(T,'descend');
% a = find(T == 0,1);
% T(a:end) = [];
% I(a:end) = [];
% 
% ngrams = zeros(a-1,maxorder);
% for k = 1:length(T)
%     ngrams(k,:) = getngram(I(k),alphsize);    
% end
% 
% freqs = T;
% 
% 
% 





