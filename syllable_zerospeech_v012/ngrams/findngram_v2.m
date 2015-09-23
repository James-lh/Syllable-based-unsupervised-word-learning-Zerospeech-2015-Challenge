function locs = findngram_v2(seq,ngram)

% Finds the location of an ngram in the sequence

%alphsize = max(seq);

order = length(ngram);

%ref_v = getloc(ngram,alphsize);
    
ngram = ngram';
locs = [];
    
for k = 1:length(seq)-order+1
    y = seq(k:k+order-1);
    %[y ngram]    
    if(~nansum(y-ngram))
       locs = [locs;k]; 
    end
    
end