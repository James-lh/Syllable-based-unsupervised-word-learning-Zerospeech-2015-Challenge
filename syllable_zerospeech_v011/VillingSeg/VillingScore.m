function s = VillingScore(x,idx,c1,c2)

s = zeros(length(idx),1);

for i = 1:length(idx)    
    j = idx(i); % Index in vector X
    
    if(x(j) < c1)
        s(i) = 0;
    elseif(x(j) >= c2)
        s(i) = 1;
    else
        s(i) = (x(j)-c1)/(c2-c1);
    end    
end


