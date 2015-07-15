function locs = findngram(seq,ngram)

% Finds the location of an ngram in the sequence

alphsize = max(seq);

order = length(ngram);

ref_v = getloc(ngram,alphsize);
    
locs = [];
    
for k = 1:length(seq)-order+1
    seqloc = seq(k:k+order-1);
    v = getloc(seqloc,alphsize);
    if v == ref_v
       locs = [locs;k]; 
    end
    
end