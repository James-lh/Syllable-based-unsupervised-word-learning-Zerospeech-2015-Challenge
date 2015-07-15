function loc = getloc(subseq,alphsize)

alphsize = alphsize+1;

loc = 0;
for k = 1:length(subseq)    
    loc = loc+subseq(end-k+1)*alphsize^(k-1);
end
